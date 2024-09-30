//
//  PerformancesView.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import AppUtil

public struct PerformancesView: View {
    
    @Environment(Concert.self)
    private var concert
        
    public init(){
    }
    
    public var body: some View {
        List{
            ForEach(concert.performances){ performance in
                
                NavigationLink(value: performance) {
                    Text(Formatter.calendarFormatter.string(from: performance.performanceAt))
                }
            }
        }
        .navigationDestination(for: Performance.self){ performance in
            let maps = Maps(id: performance.mapId, performanceId: performance.id)
            return MapsView(maps: maps)
                .environment(concert)
                .environment(performance)
        }
        .task {
            try? await concert.fetchPerformance()
        }                
    }
    
}

#Preview {
    let mock = Concert(id: 1, name: "Water Bom", description: "Hello")
    return PerformancesView()
        .environment(mock)
}
