//
//  RefreshTokenRequest.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/03.
//

import Foundation

struct RefreshTokenRequest : APIRequest{
    typealias Output = OAuthToken
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(refreshToken : String) {
        self.endpoint = BaseURL.authBaseURL.appendingPathComponent("/member/issue/refresh")
        self.method = .post
        self.query = [            
            "refreshToken" : refreshToken
        ]
        self.header = [:]
    }
}
