//
//  ReservationsRequest.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


struct ReservationsRequest: APIRequest{
    typealias Output = ReservationsResponse
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(baseURL: URL) {
        self.endpoint = baseURL.appendingPathComponent("/reservations")
        self.method = .get
        self.query = [:]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
    
}


struct ReservationsResponse: Decodable{
    var items: [ReservationResponse]
    var continuationToken: String?
}
