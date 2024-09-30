//
//  PerformancesRequest.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks

struct PerformancesRequest: APIRequest{
    typealias Output = [Performance]
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(concertId: Int) {
        self.endpoint = BaseURL.performanceURL.appendingPathComponent("performances")
        self.method = .get
        self.query = [
            "concertId": concertId
        ]
        self.header = [:]
    }
}
