//
//  File.swift
//  
//
//  Created by 한현규 on 7/29/24.
//

import Foundation
import Networks


struct SignupRequest: APIRequest{
    
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(email: String, password: String) {
        self.endpoint = BaseURL.userBaseURL.appendingPathComponent("/member/signup")
        self.method = .post
        self.query = [
            "email": email,
            "password": password
        ]
        self.header = [:]
    }        
}
