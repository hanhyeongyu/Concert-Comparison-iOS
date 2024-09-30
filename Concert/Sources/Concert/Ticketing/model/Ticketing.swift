//
//  File.swift
//  Concert
//
//  Created by 한현규 on 9/26/24.
//

import Foundation
import Networks

@Observable
final class Ticketing: Hashable{
    
    private let performanceId: Int
    var tickets: [Ticket]
    var selected: [Ticket]
        
    init(performanceId: Int, tickets: [Ticket]) {
        self.performanceId = performanceId
        self.tickets = tickets
        self.tickets = tickets
        self.selected = []
    }
    
    func selectSeats(seats: [Seat]) async throws{
        let tickets = tickets.filter { ticket in
            seats.contains { seat in
                seat.id == ticket.seatId
            }
        }
        try await Ticket.selectTickets(ticketIds: tickets.map(\.id))
        self.selected = tickets
    }
    
    func issueTickets() async throws{
        try await Ticket.issueTickets(ticketIds: selected.map(\.id))
    }
    
    func totalPrice() -> Int{
        return 6000 * selected.count
    }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(performanceId)
    }
    
    static func == (lhs: Ticketing, rhs: Ticketing) -> Bool {
        lhs.performanceId == rhs.performanceId
    }
    
}
