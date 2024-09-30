//
//  AuthApi.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation

public protocol AuthApi{
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Output?, Error?) -> Void)
    func send<T: APIRequest>(_ request: T) async throws -> T.Output
}
