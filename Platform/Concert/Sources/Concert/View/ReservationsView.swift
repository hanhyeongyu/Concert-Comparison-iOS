//
//  ReservationView.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import SwiftUI

public struct ReservationsView: View {
    
    public static let tag = "ReservationsView"
    
    @State
    private var reservations: [Reservation]
    
    @State
    private var continuationToken: String? = nil
    
    public init() {
        self.reservations = []
    }
    
    public var body: some View {
        List {
            ForEach(reservations){ reservation in
                NavigationLink(value: reservation) {
                    ReservatoinCatalogRow(reservation: reservation)
                }
                .onAppear{
                    if reservations.last == reservation{
                        Task{
                            try await fetch()
                        }
                    }
                }
            }
        }
        .navigationDestination(for: Reservation.self) { reservation in
            ReservationDetailView()
                .environment(reservation)
        }
        .task {
            try? await fetch()
        }
    }
    
    private func fetch() async throws{
        if isEnd(){
            return
        }
        
        let result = try await ReservstionApi.shared.reservations()
        self.continuationToken = result.continuationToken
        await MainActor.run {
            self.reservations = result.items.map(Reservation.init)
        }
    }
    
    private func isEnd() -> Bool{
        !reservations.isEmpty && continuationToken == nil
    }
}

#Preview {
    ReservationsView()
}
