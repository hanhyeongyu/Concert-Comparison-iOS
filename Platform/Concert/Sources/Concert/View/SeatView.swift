//
//  SeatView.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI

struct SeatView: View {
    
    private let seat: Seat
    
    init(seat: Seat) {
        self.seat = seat
    }
    
    var body: some View {
        if seat.isEnable{
            Text(seat.title())
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.1)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(width: 25, height: 25)
                .padding(4.0)
                .background(!seat.isSelected ? Color.black.opacity(0.7) : Color.blue.opacity(1.0))
        }else{
            Image(systemName: "xmark")
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 25.0, height: 25.0)
                .padding(4.0)
                .background(Color.black.opacity(0.7))
        }
    }
}

#Preview {
    let mock = Seat(id: 1, mapId: 1, seatInfo: "1열 1", rowNum: 0, seatNum: 31, posTop: 0, posLeft: 0)
    return SeatView(seat: mock)
}
