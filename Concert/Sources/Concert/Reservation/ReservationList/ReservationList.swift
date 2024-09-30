//
//  ReservationList.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import SwiftUI
import LogUtil

struct ReservationList: View {        
    
    @State
    private var reservations: [Reservation]
    
    @State
    private var continuationToken: String? = nil
    
    @State
    private var selected: Reservation?
    
    init() {
        self.reservations = []        
    }
    
    var body: some View {
        
        List(reservations){ reservation in
            Button {
                selected = reservation
            } label: {
                ReservationRow(reservation: reservation)
                    .aspectRatio(3 / 1, contentMode: .fit)
                    .padding(16.0)
            }
            .buttonStyle(PlainButtonStyle())
            .tint(.primary)
            .listRowInsets(.init())
            .listRowSeparator(.visible)
            .onAppear{
                if reservations.last == reservation{
                    Task{
                        try await fetch()
                    }
                }
            }
            
        }
        .listStyle(.plain)
        .sheet(item: $selected){ reservation in
            ReservationDetail(reservation: reservation)                   
        }
        .task {
            do{
                try await fetch()
            }catch{
                Log.e("Failed fetch reservation: \(error)")
            }
        }
    }
    
    private func fetch() async throws{
        if isEnd(){
            return
        }
        
        let page = try await Reservation.reservations(continuationToken: continuationToken)
        await MainActor.run {
            self.continuationToken = page.continuationToken
            self.reservations.append(contentsOf: page.items)
        }
    }
    
    private func isEnd() -> Bool{
        !reservations.isEmpty && continuationToken == nil
    }
}

#Preview {
    ReservationList()
}
