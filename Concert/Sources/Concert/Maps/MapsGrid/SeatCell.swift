//
//  SeatCell.swift
//
//
//  Created by 한현규 on 8/20/24.
//

import SwiftUI

struct SeatCell: View {
    
    private let row: Int
    private let col: Int
        
    private let seats: [Seat]
    
    @Environment(SeatSelection.self)
    private var selection: SeatSelection
    
    @Environment(Ticketing.self)
    private var ticketing: Ticketing
    
    
    init(
        row: Int,
        col: Int,
        seats: [Seat]
    ) {
        self.row = row
        self.col = col
        self.seats = seats
    }
    
    var body: some View {
        switch status(){
        case .EMPTY :
            Rectangle()
                .foregroundStyle(.clear)
                .frame(width: 25.0, height: 25.0)
        case .LOCKED:
            Image(systemName: "xmark")
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 21.0, height: 21.0)
                .padding(4.0)
                .background(Color.black.opacity(0.7))
        case .ENABLE:
            Text(seat()!.title())
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.1)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(width: 21.0, height: 21.0)
                .padding(4.0)
                .background(Color.black.opacity(0.7))
                .onTapGesture {
                    selection.toogle(seat: seat()!)
                }
        case .SELECTED:
            Text(seat()!.title())
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.1)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(width: 21.0, height: 21.0)
                .padding(4.0)
                .background(Color.blue.opacity(1.0))
                .onTapGesture {
                    selection.toogle(seat: seat()!)
                }
        }
        
        

    }
    
    
    private func status() -> Status{
        guard let seat = seat() else { return .EMPTY }
        guard let ticket = ticket(seat: seat) else { return .LOCKED }
        
        if !ticket.enable{
            return .LOCKED
        }else if selection.isSelect(seat: seat){
            return .SELECTED
        }else{
            return .ENABLE
        }
    }
    
    
    func seat() -> Seat?{
        seats.first(where: { seat in
            seat.posTop == self.row && seat.posLeft == self.col
        })
    }
    
    func ticket(seat: Seat) -> Ticket?{
        ticketing.tickets.first(where: { ticket in
            ticket.seatId == seat.id
        })
    }
    
    enum Status{
        case EMPTY
        case SELECTED
        case ENABLE
        case LOCKED
    }
}

//#Preview {
//    CellRow()
//}
