//
//  ReservationDetail.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import SwiftUI
import AppUtil

struct ReservationDetail: View {
                        
    private var reservation: Reservation
    
    @State
    private var items: [ReservationItem]
    
    @Environment(\.dismiss)
    private var dismiss

    
    init(reservation: Reservation) {
        self.reservation = reservation
        items = []
    }
    
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.primary)

            }
            .padding()
            
            HStack{
                VStack {
                    HStack{
                        Text("예약정보")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                                        
                    
                    HStack{
                        Text(reservation.concertName)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .padding(.top, 8.0)
                    
                    HStack(alignment: .top){
                        HStack(alignment: .top){
                            Text("장소:")
                            Text(reservation.locationName)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 8.0)
                    
                    
                    HStack(alignment: .top){
                        HStack(alignment: .top){
                            Text("공연날짜")
                            Text(Formatter.calendarFormatter.string(from: reservation.performanceDate))
                        }
                        Spacer()
                    }
                    
                    HStack(alignment: .top){
                        HStack(alignment: .top){
                            Text("인원")
                            Text("\(reservation.numberOfTickets)명")
                        }
                        Spacer()
                    }
                    
                    HStack{
                        HStack(alignment: .top){
                            Text("좌석")
                            Text(items.map{ $0.seat}.map{ $0.title()}.joined(separator: ", ") )
                        }
                        Spacer()
                    }
        
                }
                
                Spacer()
            }.padding()
            
            
            
            
            Divider()
                .frame(height: 15.0)
            
            VStack {
                HStack {
                    Text("결제 정보")
                        .font(.title3)
                    
                    Spacer()
                    
                    Text(Formatter.calendarFormatter.string(from: reservation.reservationAt))
                        .font(.caption)
                }
                
                HStack{
                    Text("결제 금액")
                    
                    Spacer()
                    
                    Text(Formatter.decimalFormatter.string(from: reservation.totalPrice as NSNumber)!)
                        .font(.caption)
                }
                .padding(.top, 8.0)
            }.padding()
            
            Spacer()
        }.task {
            do{
                items =  try await reservation.items()
            }catch{
                print(error)
            }
        }
        
        
    }
    
}



#Preview{
    let reservation = Reservation(
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
    
    return ReservationDetail(reservation: reservation)
}
