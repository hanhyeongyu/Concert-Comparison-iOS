//
//  ReservatoinCatalogRow.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import SwiftUI
import AppUtil

public struct ReservatoinCatalogRow: View {
    
    private let reservation: Reservation
    
    public init(reservation: Reservation){
        self.reservation = reservation
    }
    
    public var body: some View {
        VStack{
            Text(reservation.concert.name)
            Text(Formatter.calendarFormatter.string(from: reservation.performance.performanceAt))
        }
    }
}

//#Preview {
//    ReservatoinCatalogRow()
//}
