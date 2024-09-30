//
//  Maps.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import SwiftUI

@Observable
class Maps{
        
    var cells: [[Cell]]
    
    let id: Int
    let performanceId: Int
    var locationId: Int?
    var width: Int
    var height: Int
    
    
    init(id: Int, performanceId: Int) {
        self.id = id
        self.performanceId = performanceId
        self.locationId = nil
        self.width = 0
        self.height = 0
        self.cells = []
    }
    
    
    func fetchMaps() async throws{
        if !cells.isEmpty{
            return
        }
        
        async let maps = try ConcertApi.shared.maps(id)
        async let seats = try ConcertApi.shared.seats(id)
        async let tickets = try ConcertApi.shared.tickets(performanceId)
        await updateMaps(
            mapsResponse: try await maps,
            seatsResponses: try await seats,
            ticketsResponse: try await tickets
        )
    }
    
    func selectSeat(seat: Seat){
        seat.toggle()
    }
    
    func selectedSeats() -> [Seat]{
        cells.flatMap { $0 }.compactMap { cell in
            cell as? Seat
        }.filter{
            $0.isSelected
        }
    }
    
    @MainActor
    private func updateMaps(mapsResponse: MapsResponse, seatsResponses: [SeatsResponse], ticketsResponse: [TicketsResponse]){
        self.locationId =  mapsResponse.locationId
        self.width = mapsResponse.width
        self.height = mapsResponse.height
        
        for i in 0..<height{
            var row = [Cell]()
            for j in 0..<width{
                row.append(Cell(posTop: i, posLeft: j))
            }
            cells.append(row)            
        }
        
        let seats = seatsResponses.map(Seat.init)
        let tickets = ticketsResponse.map(Ticket.init)
        for ticket in tickets {
            if let findSeat = seats.first(where: { seat in seat.id == ticket.seatId }){
                findSeat.ticketId = ticket.id
                findSeat.isEnable = ticket.enable
            }
        }
        
        
        for seat in seats {
            cells[seat.posTop][seat.posLeft] = seat
        }
        
        
    }
}

