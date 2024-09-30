//
//  SeatsRequset.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


struct SeatsRequest: APIRequest{
    typealias Output = [Seat]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(mapId: Int) {
        self.endpoint = BaseURL.mapsURL.appendingPathComponent("/seats")
        self.method = .get
        self.query = [
            "mapsId": mapId
        ]
        self.header = [:]
    }
    
    
}
