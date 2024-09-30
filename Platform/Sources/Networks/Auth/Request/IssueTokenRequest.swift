//
//  IssueTokenRequest.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/03.
//

import Foundation


struct IssueTokenRequest : APIRequest{
    typealias Output = OAuthToken
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(id: String , password: String) {
        self.endpoint =  BaseURL.authBaseURL.appendingPathComponent("/member/issue")
        self.method = .post
        self.query = [
            "email" : id,
            "password" : password
        ]
        self.header = [:]
    }
}
