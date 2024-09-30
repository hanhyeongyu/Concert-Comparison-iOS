//
//  SeatGrid.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import AppUtil
import UIUtil
import LogUtil

struct MapsGrid: View {
    
    
    private let concert: Concert
    
    private let performance: Performance
        
    private let maps: Maps
    
    @State
    private var ticketing: Ticketing
    
    @State
    private var selection: SeatSelection
    
    @State
    private var payment: Payment?
    
    @Binding
    private var path: NavigationPath
    
    @State
    private var selectError: Error? = nil
    
    
    init(
        concert: Concert,
        performance: Performance,
        maps: Maps,
        tickets: [Ticket],
        path: Binding<NavigationPath>
    ) {
        self._path = path
        self.concert = concert
        self.performance = performance
        self.maps = maps
        self.ticketing = Ticketing(performanceId: performance.id, tickets: tickets)
        self.selection = SeatSelection()
    }
    
    var body: some View {
        VStack{
            ScrollView([.horizontal, .vertical]){
                VStack(alignment: .center){
                    Image("img-theater-screen", bundle: .module)
                        //.frame(width: .greatestFiniteMagnitude)
                        .padding(.vertical, 32.0)
                    
                    Grid(horizontalSpacing: 1.0, verticalSpacing: 1.0 ) {
                        ForEach(0..<maps.height, id: \.self) { row in
                            GridRow {
                                ForEach(0..<maps.width, id: \.self) { col in
                                    SeatCell(
                                        row: row,
                                        col: col,
                                        seats: maps.seats
                                    )
                                    .environment(selection)
                                    .environment(ticketing)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24.0)
                    
                }
                .padding(.vertical, 32.0)
            }
            
            Divider()
            
            VStack(alignment: .leading){
                
                Text(performance.location.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.bottom, 8.0)
                
                
                Divider()
                
                HStack{
                    Text("Seats")
                        .font(.caption2)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(
                        selection.selected
                            .sorted(by: { lhs, rhs in
                                if lhs.rowNum == rhs.rowNum{
                                    return lhs.seatNum < rhs.seatNum
                                }else{
                                    return lhs.rowNum < rhs.rowNum
                                }
                            })
                            .map{ $0.title() }
                            .joined(separator: ", ")
                    )
                    .font(.caption2)
                    .foregroundColor(.primary)
                }
                
                
                HStack{
                    Text("People")
                        .font(.caption2)
                    
                    Spacer()
                    
                    Text("\(selection.selected.count)")
                        .font(.caption2)
                }
                .padding(.top, 4.0)
                
                Divider()
                
                
                HStack{
                    Text("Total Price")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(
                        "\(Formatter.currencyFormatter.string(from: ticketing.totalPrice() as NSNumber)!)"
                    )
                    .font(.callout)
                    .fontWeight(.bold)
                }
                .padding([.top, .leading, .trailing], 16.0)
            }.padding()
            
                        
            Button(action: {
                Task{
                    do{
                        let seats = selection.selected.map(\.self)
                        try await ticketing.selectSeats(seats: seats)
                        path.append(ticketing)
                    }catch{
                        self.selectError = error
                    }
                }
            }){
                Text("Payment")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
            }
        }
        .navigationTitle(concert.name)
        .navigationDestination(for: Ticketing.self) { selection in
            OrderHome(
                path: $path,
                concert: concert,
                performnace: performance,
                ticketing: ticketing
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .alert(
            "이미 선정된 좌석입니다.",
            isPresented: Binding(value: $selectError)
        ){
            Button("OK", role: .cancel){}
        }
    }
    
    
    
    
    
}

#Preview {
    let concert = Concert(
        id: 1,
        name: "Waterbom",
        description: "Hello",
        posterURL: URL(string: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    )
    
    let performance = Performance(
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
    )
    
    
    let map = MapsGrid(
        concert: concert,
        performance: performance,
        maps: Maps(id: 1, locationId: performance.location.id, width: 10, height: 10, seats: []),
        tickets: [],
        path: .constant(.init())
    )
    
    return map
}
