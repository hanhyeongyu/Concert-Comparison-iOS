//
//  Network.swift
//  WelcomeKorea
//
//  Created by 한현규 on 2023/02/01.
//

import Foundation
import AppUtil
import Alamofire

public protocol Api: AnyObject {
    
    //request data
    func send<T: APIRequest>(_ request: T , sessionType: SessionType, completion: @escaping (T.Output?, Error?) -> Void)
    func send<T: APIRequest>(_ request: T , sessionType: SessionType) async throws -> T.Output
    
    
    //almofires session
    func addSession(type:SessionType, session: Session)
}


 
// MARK: QueryItems, HTTPHeader
public typealias QueryItems = [String: AnyHashable]
public typealias HTTPHeader = [String: String]



// MARK: HTTPMethod
public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}




// MARK: Session
public enum SessionType {        
    case Api
    case AuthApi    //Token (withRetrier)
}

// MARK: Request
public protocol APIRequest: Hashable {
    associatedtype Output: Decodable
    
    var endpoint: URL { get }
    var method: HTTPMethod { get }
    var query: QueryItems { get }
    var header: HTTPHeader { get }
}

