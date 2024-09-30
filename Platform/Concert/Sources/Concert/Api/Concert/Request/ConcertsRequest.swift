//
//  File.swift
//  
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


struct ConcertsRequest: APIRequest{
    typealias Output = ConcertsResponse
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, continuationToken: String?) {
        self.endpoint = baseURL.appendingPathComponent("concerts")
        self.method = .get
        self.query = [:]
        self.header = [
            "Content-Type": "application/json"
        ]
        
        if continuationToken != nil{
            query["continuationToken"] = continuationToken        
        }
    }
    
}


struct ConcertsResponse: Decodable{
    var items: [ConcertResponse]
    var continuationToken: String?
}


public struct ConcertResponse: Decodable{
    
    public let id: Int
    public let name: String
    public let description: String
    
    public static func ==(lhs: ConcertResponse, rhs: ConcertResponse) -> Bool{
        return lhs.id == rhs.id
    }
}
