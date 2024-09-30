//
//  AddReservationRequest.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks

struct AddReservationRequest: APIRequest{
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader

    
    init(baseURL: URL, concertId: Int, performanceId: Int, paymentId: String, ticketIds: [Int]) {
        self.endpoint = baseURL.appendingPathComponent("/reservations")
        self.method = .post
        self.query = [
            "concertId": concertId,
            "paymentKey": paymentId,
            "performanceId": performanceId,
            "ticketIds": ticketIds
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
    
}



