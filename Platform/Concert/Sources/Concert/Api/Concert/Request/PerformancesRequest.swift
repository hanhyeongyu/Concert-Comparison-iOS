//
//  PerformancesRequest.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks

struct PerformancesRequest: APIRequest{
    typealias Output = [PerformanceResponse]
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, concertId: Int) {
        self.endpoint = baseURL.appendingPathComponent("performances")
        self.method = .get
        self.query = [
            "concertId": concertId
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
}


struct PerformanceResponse: Decodable{
    let id: Int
    let concertId: Int
    let mapId: Int
    let performanceAt: Date
}
