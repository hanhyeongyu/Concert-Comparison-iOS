//
//  File.swift
//  
//
//  Created by 한현규 on 8/18/24.
//

import Foundation


@Observable
public class Reservation: Identifiable, Hashable{
    let reservationId: String
    let userId: Int
    let paymentId: String
    let concert: Concert
    let performance: Performance
    
    init(reservationResponse: ReservationResponse) {
        self.reservationId = reservationResponse.reservationId
        self.userId = reservationResponse.userId
        self.paymentId = reservationResponse.paymentId
        self.concert = Concert(response: reservationResponse.concert)
        self.performance = Performance(response: reservationResponse.performance)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(reservationId)
    }
    
    public static func == (lhs: Reservation, rhs: Reservation) -> Bool {
        lhs.reservationId == rhs.reservationId
    }
}
