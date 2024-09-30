//
//  File.swift
//  
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import AppUtil
import Networks


struct ConcertsRequest: APIRequest{
    typealias Output = Page<Concert>
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(continuationToken: String?) {
        self.endpoint = BaseURL.concertURL.appendingPathComponent("/concerts")
        self.method = .get
        self.query = continuationToken != nil ? ["continuationToken": continuationToken!] : [:]
        self.header = [:]
    }
    
}

