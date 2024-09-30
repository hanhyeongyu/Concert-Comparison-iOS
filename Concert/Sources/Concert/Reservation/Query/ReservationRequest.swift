//
//  ReservationRequest.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


struct ReservationRequest: APIRequest{
    typealias Output = Reservation
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(reservationId: String) {
        self.endpoint = BaseURL.reservationURL.appendingPathComponent("/reservations")
        self.method = .get
        self.query = [
            "reservationId": reservationId
        ]
        self.header = [:]
    }        
    
}
