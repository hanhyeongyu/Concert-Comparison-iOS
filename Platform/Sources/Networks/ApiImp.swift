//
//  NetworkImp.swift
//  WelcomeKorea
//
//  Created by 한현규 on 2023/02/01.
//

import Foundation
import AppUtil
import Alamofire
import CocoaLumberjackSwift


public let API: Api = ApiImp.shared


public class ApiImp: Api {
    
    public static let shared = ApiImp()
    
    public var sessions : [SessionType:Session] = [SessionType:Session]()
    
    private init() {
        initSession()
    }
    
    public func send<T>(
        _ request: T,
        sessionType: SessionType,
        completion: @escaping (T.Output?, Error?) -> Void
    ) where T : APIRequest {
        let urlRequest = try! RequestFactory(request: request).urlRequestRepresentation()
        let session = session(sessionType)
        session.request(urlRequest)
            .validate({ [unowned self] (_, response, data) -> Alamofire.Request.ValidationResult in
                validate(request, sessionType: sessionType, response: response, data: data)
            })
            .responseData(
                emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
                emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
            ){ [unowned self] response in
                do{
                    let result = try responseData(request: request, response: response, sessionType: sessionType)
                    completion(result, nil)
                }catch(let error){
                    completion(nil, error)
                }
            }
    }    
    
    public func send<T>(
        _ request: T,
        sessionType: SessionType
    ) async throws -> T.Output where T : APIRequest {
        let urlRequest = try RequestFactory(request: request).urlRequestRepresentation()
        let session = session(sessionType)
        
        let dataRequest = session.request(urlRequest)
            .validate({ [unowned self] (a, response, data) -> Alamofire.Request.ValidationResult in
                validate(request, sessionType: sessionType, response: response, data: data)
            })
    
            
        let response = await dataRequest.serializingData(
            emptyResponseCodes: ApiImp.defaultEmptyResponseCodes,
            emptyRequestMethods: ApiImp.defaultEmptyRequestMethods
        ).response
                                    
        let result =  try responseData(request: request, response: response, sessionType: sessionType)
        return result
    }

}



// MARK: Validation
extension ApiImp{
    private func validate<T>(
        _ request: T,
        sessionType: SessionType,
        response: HTTPURLResponse,
        data: Data?
    ) -> Request.ValidationResult where T : APIRequest {
        DDLogDebug("===================================================================================================")
        DDLogDebug("session: \n type: \(sessionType)\n\n")
        
        DDLogInfo("request: \n method: \(request.method)\n url:\(request.endpoint)\n headers:\(request.header)\n parameters: \(request.query)) \n\n")
        
        if let data = data {
            var json : Any? = nil
            do {
                json = try JSONSerialization.jsonObject(with:data, options:[])
            } catch {
                DDLogError("JSONSerialization fail: \(error)}")
            }
            DDLogInfo("response:\n \(String(describing: json))\n\n" )
            
            if let appError = AppError(response: response, data: data) {
                return .failure(appError)
            }else {
                return .success(Void())
            }
        }else {
            if 200 ..< 300 ~= response.statusCode {
                return .success(Void())
            }else{
                return .failure(AppError(reason: .Unknown, message: "data is nil."))
            }
        }
    }
}

// MARK: ResponseData
extension ApiImp{
    private func responseData<T>(
        request: T,
        response: AFDataResponse<Data>,
        sessionType: SessionType
    ) throws -> T.Output where T : APIRequest {
        if let afError = response.error, let retryError = self.getRequestRetryFailedError(error:afError) {
            DDLogError("response:\n api error: \(retryError)")
            throw retryError
        }else if let afError = response.error, self.getError(error:afError) == nil {
            DDLogError("response:\n not api error: \(afError)")
            throw afError
        }else if T.Output.self == Empty.self, let _ = response.response {
            return Empty() as! T.Output
        }else if  let data = response.data, let response = response.response {
            if let appError = AppError(response: response, data: data) {
                throw appError
            }
            let output = try AppJSONDecoder.springIso8601Date.decode(T.Output.self, from: data)
            return output
        }else{
            DDLogError("response:\n error: response  is nil.")
            throw AppError(reason: .Unknown, message: "response is nil.")
        }
    }
}

extension ApiImp{
    fileprivate static let defaultEmptyResponseCodes :Set<Int> = [200, 204, 205]
    fileprivate static let defaultEmptyRequestMethods: Set<Alamofire.HTTPMethod> = [.head, .get, .post]
}

// MARK: Session
extension ApiImp{
    private func initSession(){
        let apiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        apiSessionConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        addSession(type: .Api, session:Session(configuration: apiSessionConfiguration, interceptor: ApiRequestAdapter()))
    }
    
    
    public func addSession(type:SessionType, session:Session) {
        if self.sessions[type] == nil {
            self.sessions[type] = session
        }
    }
    
    public func session(_ sessionType: SessionType) -> Session {
        return sessions[sessionType] ?? sessions[.Api]!
    }
}




final class RequestFactory<T: APIRequest> {
    
    let request: T
    private var urlComponents: URLComponents?
    
    init(request: T) {
        self.request = request
        self.urlComponents = URLComponents(url: request.endpoint, resolvingAgainstBaseURL: true)
    }
    
    func urlRequestRepresentation() throws -> URLRequest {
        switch request.method {
        case .get:
            return try makeGetRequest()
        case .post:
            return try makePostRequest()
        case .put:
            return try makePutRequest()
        case .delete :
            return try makeDeleteRequest()
        }
    }
    
    private func makeGetRequest() throws -> URLRequest {
        if request.query.isEmpty == false {
            urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        return try makeURLRequest()
    }
    
    private func makePostRequest() throws -> URLRequest {
        let body = try JSONSerialization.data(withJSONObject: request.query, options: [])
        return try makeURLRequest(httpBody: body)
    }
    
    private func makePutRequest() throws -> URLRequest {
        if request.query.isEmpty == false {
            urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        return try makeURLRequest()
    }
    
    private func makeDeleteRequest() throws -> URLRequest {
        return try makeURLRequest()
    }
    
    private func makeURLRequest(httpBody: Data? = nil) throws -> URLRequest {
        guard let url = urlComponents?.url else {
            throw AppError(reason: .NotSupported)
        }
        
        var urlRequest = URLRequest(url: url)
        
        
        if request.header.isEmpty{
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }else{
            request.header.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = httpBody
                
        return urlRequest
    }
}
