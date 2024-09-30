//
//  SelectTicketsRequest.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks

struct SelectTicketsRequest: APIRequest{
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, ticketIds: [Int]) {
        self.endpoint = baseURL.appendingPathComponent("ticket/select")
        self.method = .post
        self.query = [
            "ticketIds" : ticketIds
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
        
}
