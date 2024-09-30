//
//  SwiftUIView.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import SwiftUI
import AppUtil

public struct PaymentView: View {

    @Environment(Concert.self)
    private var concert
    
    @Environment(Performance.self)
    private var performance
    
    private let payment: Payment
    
    var seats: [Seat]!
    
    public init(seats: [Seat]){
        self.seats = seats
        self.payment = Payment()
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        VStack {
            
            Text(concert.name)
            Text(concert.description)
            Text(Formatter.calendarFormatter.string(from: performance.performanceAt))
            Text(
                seats.map{ seat in seat.title()}.joined(separator: ", ")
            )
            
            Spacer()
            
            Button(action: {
                Task{
                    
                    let paymentApi = PaymentApi.shared
                    let amount = 12000
                    let payment = try await paymentApi.add(amount)
                    let url = try await paymentApi.request(paymentId: payment.paymentId, amount: payment.amount)
                    try await paymentApi.confirm(paymentId: payment.paymentId, paymentKey: paymentKey(url: url), amount: amount)
                    
                    let concertAPi = ConcertApi.shared
                    
                    let ticketIds = seats.compactMap{ $0.ticketId }
                    
                    try await concertAPi.issueTickets(ticketIds: ticketIds)
                    try await ReservstionApi.shared.addReservation(
                        concertId: concert.id,
                        performanceId: performance.id,
                        paymentId: payment.paymentId,
                        ticketIds: ticketIds
                    )
                }
            }){
                Text("결제하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
            }
        }.ignoresSafeArea()
        
    }
    
    
    private func queryItems(url : URL) -> [URLQueryItem]{
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        return items
    }
    

    private func paymentKey(url: URL) -> String{
        let key = "paymentKey"
        return queryItems(url: url).first { $0.name == key
        }!.value!
    }
}

#Preview {
    PaymentView(seats: [])
}
