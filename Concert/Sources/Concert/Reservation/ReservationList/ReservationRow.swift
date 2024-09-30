//
//  ReservationRow.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import SwiftUI
import AppUtil
import Kingfisher

struct ReservationRow: View {
    
    private let reservation: Reservation
    
    init(reservation: Reservation){
        self.reservation = reservation
    }
    
    var body: some View {
        HStack(alignment: .top){
            KFImage(reservation.posterURL)
                .resizable()
                .aspectRatio(2/3, contentMode: .fit)                
            
            VStack(alignment: .leading){
                Text(reservation.concertName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(Formatter.calendarFormatter.string(from: reservation.performanceDate))
                    .font(.caption)
                    
                
                Text(reservation.locationName)
                    .font(.caption)
                    
                
                Spacer()
            }
            
            Spacer()
        }        
    }
}

#Preview {
    let mock = Reservation(
        id: 1,
        reservationId: UUID(),
        userId: 1,
        concertId: 1,
        performanceId: 1,
        locationId: 1,
        mapsId: 1,
        paymentId: UUID(),
        status: .RESERVATION,
        reservationAt: Date(),
        concertName: "Spring Concert",
        performanceName: "first",
        performanceDate: Date(),
        locationName: "Seoul",
        numberOfTickets: 2,
        totalPrice: 12000,
        posterURL: URL(string: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    )
    return ReservationRow(reservation: mock)
        .aspectRatio(3 / 1, contentMode: .fit)
}
