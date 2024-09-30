//
//  Ticket.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks


final class Ticket: Hashable, Decodable{

    let id: Int
    let performanceId: Int
    let mapId: Int
    let seatId: Int
    let enable: Bool
    
    init(id: Int, performanceId: Int, mapId: Int, seatId: Int, enable: Bool) {
        self.id = id
        self.performanceId = performanceId
        self.mapId = mapId
        self.seatId = seatId
        self.enable = enable
    }
            
    
    static func cancelTickets(ticketIds: [Int]) async throws{
        
    }
    
    static func selectTickets(ticketIds: [Int]) async throws{
        let request = SelectTicketsRequest(ticketIds: ticketIds)
        _ =  try await AUTHAPI.send(request)
    }
    
    
    static func issueTickets(ticketIds: [Int]) async throws{
        let request = IssueTicketsRequest(ticketIds: ticketIds)
        _ = try await AUTHAPI.send(request)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.id == rhs.id
    }
}
