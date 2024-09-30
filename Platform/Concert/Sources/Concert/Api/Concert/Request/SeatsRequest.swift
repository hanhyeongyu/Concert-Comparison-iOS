//
//  SeatsRequset.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


struct SeatsRequest: APIRequest{
    typealias Output = [SeatsResponse]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, mapId: Int) {
        self.endpoint = baseURL.appendingPathComponent("seats/\(mapId)")
        self.method = .get
        self.query = [:]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
    
    
}

struct SeatsResponse: Decodable{
    let id: Int
    let mapId: Int
    let seatInfo: String
    let rowNum: Int
    let seatNum: Int
    let posTop: Int
    let posLeft: Int
}
