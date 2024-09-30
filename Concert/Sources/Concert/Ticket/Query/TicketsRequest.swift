//
//  TicketsRequest.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks


struct TicketsRequest: APIRequest{
    typealias Output = [Ticket]
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(performanceId: Int) {
        self.endpoint = BaseURL.ticketURL.appendingPathComponent("tickets")
        self.method = .get
        self.query = [
            "performanceId": performanceId
        ]
        self.header = [:]
    }
}
