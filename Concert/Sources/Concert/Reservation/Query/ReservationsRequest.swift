//
//  ReservationsRequest.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import AppUtil
import Networks


struct ReservationsRequest: APIRequest{
    typealias Output = Page<Reservation>
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(continuationToken: String?) {
        self.endpoint = BaseURL.reservationURL.appendingPathComponent("/reservations")
        self.method = .get
        self.query = continuationToken != nil ? ["continuationToken": continuationToken!] : [:]
        self.header = [:]
    }
    
}
