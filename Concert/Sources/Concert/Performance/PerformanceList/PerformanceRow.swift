//
//  PerformanceRow.swift
//  
//
//  Created by 한현규 on 8/20/24.
//

import SwiftUI
import AppUtil

struct PerformanceRow: View {
    
    private let performance: Performance
    
    @State
    private var location: Location?
    
    init(performance: Performance) {
        self.performance = performance
    }
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading){
                HStack {
                    Text(performance.name)
                        .font(.callout)
                }
                
                if let location = location{
                    HStack {
                        Text(location.name)
                    }.font(.caption)
                }
                
                HStack {
                    Text(Formatter.timeFormatter.string(from: performance.performanceAt))
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                }
            }            
            .padding()

            Spacer()
            
            Button(action: {
            }){
                Text("Booking")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(16.0)
                    .background(Color.blue)
            }
            .clipShape(.capsule)
        }
        
                
        
    }
}

#Preview {
    let mock = Performance(
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
    return PerformanceRow(performance: mock)
}
