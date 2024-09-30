//
//  ReservationRequest.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


struct ReservationRequest: APIRequest{
    typealias Output = ReservationResponse
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(baseURL: URL, reservationId: String) {
        self.endpoint = baseURL.appendingPathComponent("/reservations")
        self.method = .get
        self.query = [
            "reservationId": reservationId
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }        
    
}







public struct ReservationResponse: Decodable{
    let reservationId: String
    let userId: Int
    let paymentId: String
    let concert: ConcertResponse
    let performance: PerformanceResponse
}

