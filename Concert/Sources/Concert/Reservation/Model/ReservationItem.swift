//
//  File.swift
//  
//
//  Created by 한현규 on 8/21/24.
//

import Foundation



final class ReservationItem: Decodable{
    
    let reservationId: String
    let ticket: Ticket
    let seat: Seat
    
    init(reservationId: String, ticket: Ticket, seat: Seat) {
        self.reservationId = reservationId
        self.ticket = ticket
        self.seat = seat
    }
}
