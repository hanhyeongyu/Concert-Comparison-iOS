//
//  MapsRequests.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


struct MapsRequests: APIRequest{
    typealias Output = MapsResponse
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, mapsId: Int) {
        self.endpoint = baseURL.appendingPathComponent("maps/\(mapsId)")
        self.method = .get
        self.query = [:]
        self.header = [
            "Content-Type" : "application/json"
        ]
    }
    
    
}



struct MapsResponse: Decodable{
    let id: Int
    let locationId: Int
    let width: Int
    let height: Int
}
