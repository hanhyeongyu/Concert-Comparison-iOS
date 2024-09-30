//
//  MapsRequest.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


struct MapsRequest: APIRequest{
    typealias Output = Maps
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(mapsId: Int) {
        self.endpoint = BaseURL.mapsURL.appendingPathComponent("maps/\(mapsId)")
        self.method = .get
        self.query = [:]
        self.header = [
            "Content-Type" : "application/json"
        ]
    }
    
}
