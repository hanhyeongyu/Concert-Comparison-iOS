//
//  ReservationItemsRequest.swift
//
//
//  Created by 한현규 on 8/21/24.
//

import Foundation
import Networks



struct ReservationItemsRequest: APIRequest{
    typealias Output = [ReservationItem]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(reservationId: String) {
        self.endpoint = BaseURL.reservationURL.appendingPathComponent("/reservations/items")
        self.method = .get
        self.query = [
            "reservationId": reservationId
        ]
        self.header = [:]
    }
    
    
}
