//
//  AddReservationRequest.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks

struct AddReservationRequest: APIRequest{        
    typealias Output = Reservation
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader

    
    init(concertId: Int, performanceId: Int, paymentId: String, ticketIds: [Int]) {
        self.endpoint = BaseURL.reservationURL.appendingPathComponent("/reservations")
        self.method = .post
        self.query = [
            "concertId": concertId,
            "paymentKey": paymentId,
            "performanceId": performanceId,
            "ticketIds": ticketIds
        ]
        self.header = [:]
    }
    
}



