//
//  OrderHome.swift
//
//
//  Created by 한현규 on 8/20/24.
//

import SwiftUI
import AppUtil

struct OrderHome: View {        
    
    @Binding
    private var path: NavigationPath
    
    private let concert: Concert
    
    private let performnace: Performance
        
    private let ticketing: Ticketing

    @State
    private var payment: Payment
    
    @State
    private var showPayment: Bool = false
    
    @State
    private var reservation: Reservation?
    
    @State
    private var loading: Bool = false
    
    init(
        path: Binding<NavigationPath>,
        concert: Concert,
        performnace: Performance,
        ticketing: Ticketing
    ) {
        self._path = path
        self.concert = concert
        self.performnace = performnace
        self.payment = Payment(
            orderName: concert.name,
            amount: ticketing.totalPrice()
        )
        self.ticketing = ticketing
    }
    
    var body: some View {
        
        if loading{
            VStack{
                ProgressView("Processing...")
            }
            
            
        }else{
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        
                        
                        VStack(alignment: .leading){
                            Text("Reservation Information")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text(concert.name)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 16.0)
                            
                            Text(Formatter.calendarFormatter.string(from: performnace.performanceAt))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text(performnace.location.name)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text("\(ticketing.selected.count) people")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.top, 8.0)
                        }.padding()
                                            
                                
                        Divider()
                        
                        VStack(alignment: .leading){
                            
                            Text("Payment price")
                                .font(.title3)
                                .fontWeight(.bold)
                                
                            
                            HStack{
                                Text("Product Price")
                                Spacer()
                                Text(totalPrice())
                            }
                            .padding(.top, 8.0)
                        
                            
                            HStack{
                                Text("Total payment")
                                Spacer()
                                Text(totalPrice())
                            }.padding(.top, 4.0)
                            
                            
                            
                        }.padding()
                    }
                    
                }
                
                Spacer()

                
                Button(action: {
                    showPayment = true
                }){
                    Text("\(totalPrice()) Pay")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(
                isPresented: $showPayment,
                onDismiss: {
                    Task{
                        if payment.status == .CONFIRM{
                            Task{
                                do{
                                    loading = true
                                    try await ticketing.issueTickets()
                                    
                                    let result = try await Reservation.addReservation(
                                        concertId: concert.id,
                                        performanceId: performnace.id,
                                        paymentId: payment.paymentId!,
                                        ticketIds: ticketing.selected.map(\.id)
                                    )
                                    try await Task.sleep(nanoseconds: 3000000000)
                                    loading = false
                                    reservation = result
                                }catch{
                                    //TODO: payment cancel
                                    print("\(error)")
                                }
                            }
                            
                        }
                    }
                }
            ){
                PaymentView(path: $path)
                    .environment(payment)
            }
            .fullScreenCover(
                item: $reservation,
                onDismiss: {
                    path = . init()
                },
                content: { reservation in
                    ReservationDetail(reservation: reservation)                       
                }
            )

        }
        
    }
    
    
    
    private func totalPrice() -> String{
        return Formatter.currencyFormatter.string(from: payment.amount as NSNumber)!
    }
}

#Preview {
    OrderHome(
        path: .constant(.init()),
        concert: Concert(
            id: 1,
            name: "Spring Concert",
            description: "Hello",
            posterURL: URL(string: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
        ),
        performnace: Performance(
            id: 1,
            concertId: 1,            
            mapId: 1, 
            name: "1회차",
            performanceAt: Date(),
            location: Location(
                id: 1,
                name: "Coex",
                address: Address(city: "Seoul", street: "Yeongdong-daero, Gangnam-gu", zipCode: "135-731")
            )
        ),        
        ticketing: Ticketing(performanceId: 1, tickets: [])
    )
    
}
