//
//  AuthApiImp.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/03.
//

import Alamofire

import CocoaLumberjackSwift


public let AUTHAPI: AuthApi = AuthApiImp.shared

public final class AuthApiImp : AuthApi{
    
    fileprivate static let shared: AuthApiImp = AuthApiImp()
    
    private init(){
        initSession()
    }
    
    public func send<T: Networks.APIRequest>(
        _ request: T ,
        completion: @escaping (T.Output?, Error?) -> Void
    ){
        API.send(request, sessionType: .AuthApi, completion: completion)
    }
    
    
    public func send<T>(
        _ request: T
    ) async throws -> T.Output where T : Networks.APIRequest {
        try await API.send(request, sessionType: .AuthApi)
    }
}


// MARK: Session
extension AuthApiImp{
    private func initSession() {
        let interceptor = Interceptor(
            adapter: AuthRequestAdapter(),
            retrier: AuthRequestRetrier()
        )
        let authApiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        authApiSessionConfiguration.tlsMinimumSupportedProtocolVersion = .TLSv12
        API.addSession(type: .AuthApi, session: Session(configuration: authApiSessionConfiguration, interceptor: interceptor))
    }
    
}

