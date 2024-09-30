//
//  TicketsRequest.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks


struct TicketsRequest: APIRequest{
    typealias Output = [TicketsResponse]
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL, performanceId: Int) {
        self.endpoint = baseURL.appendingPathComponent("tickets")
        self.method = .get
        self.query = [
            "performanceId": performanceId
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
}



struct TicketsResponse: Decodable{
    let id: Int
    let performanceId: Int
    let mapId: Int
    let seatId: Int
    let enable: Bool
}
