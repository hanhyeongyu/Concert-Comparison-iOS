//
//  MapsView.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI

struct MapsView: View {
    
    @Environment(Concert.self)
    private var concert
    
    @Environment(Performance.self)
    private var performance
    
    @State
    private var maps: Maps
        
    @State
    private var seats: [Seat]
    
    @State
    private var selectSeat: Bool = false
    
        
    @State
    private var showAlert: Bool = false

    @State
    private var errorMessage: String = ""
    
    private var gridItem = [
        GridItem(.fixed(25.0), spacing: nil, alignment: .center)
    ]
    
    
    
    init(maps: Maps) {
        self.maps = maps
        self.seats = []
    }
    
    var body: some View {
        VStack{
            ScrollView([.horizontal, .vertical]){
                
                Image("img-theater-screen", bundle: .module)
                    .frame(width: CGFloat(maps.width) * 25.0)
                    .padding(.bottom, 16.0)
                
                
                Grid(horizontalSpacing: 1.0, verticalSpacing: 1.0 ) {
                    
                    ForEach(maps.cells, id: \.self) { row in
                        GridRow {
                            ForEach(row, id: \.self) { cell in
                                if let seat = cell as? Seat{
                                    SeatView(seat: seat).onTapGesture {
                                        maps.selectSeat(seat: seat)
                                    }
                                }else{
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .frame(width: 29.0, height: 29.0)
                                }
                            }
                        }
                    }
                }
            }
            .task {
                try? await maps.fetchMaps()
            }

            
            
            Button(action: {
                Task{
                    do{
                        let selectedSeats = maps.selectedSeats()
                        let ticketIds = selectedSeats.compactMap { $0.ticketId }
                        try await ConcertApi.shared.selectTickets(ticketIds)
                            await MainActor.run {
                                self.seats = selectedSeats
                                self.selectSeat = true
                            }
                    }catch{
                        errorMessage = "이미 선정된 좌석입니다."
                        showAlert = true
                    }
                    
                }
            }){
                Text("선택")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
            }
        }
        .navigationDestination(isPresented: $selectSeat, destination: {
            PaymentView(seats: seats)
                .environment(concert)
                .environment(performance)
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text(errorMessage),
                  message: nil,
                  dismissButton: .default(Text("확인")))
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    let mock = Maps(id: 1, performanceId: 1)
    return MapsView(maps: mock)
}
