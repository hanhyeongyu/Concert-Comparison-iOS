//
//  PerformanceList.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import LogUtil

struct PerformanceList: View {
        
    private var concert: Concert
    
    @State
    private var perforemances: [Performance]
    
    @Binding
    private var path: NavigationPath
        
    init(concert: Concert, path: Binding<NavigationPath>){
        self.concert = concert
        self.perforemances = []
        self._path = path
    }
    
    var body: some View {
        List{
            ForEach(perforemances){ performance in
                Button {
                    performanceDidTap(performance: performance)
                } label: {
                    PerformanceRow(performance: performance)
                }
            }
        }
        .navigationDestination(for: PerformanceMaps.self){ performanceMaps in
            return MapsGrid(
                concert: concert,
                performance: performanceMaps.performance,
                maps: performanceMaps.maps,
                tickets: performanceMaps.tickets,
                path: $path
            )
        }
        .task {
            do{
                self.perforemances = try await concert.performances
            }catch{
                Log.e("Failed to fetch performances: \(error)")
            }
        }
    }
    
    private func performanceDidTap(performance: Performance){
        Task{
            let maps =  try await performance.maps
            let tickets = try await performance.tickets
            let result = PerformanceMaps(performance: performance, maps: maps, tickets: tickets)
            path.append(result)
        }
    }
}

#Preview {
    let concert = Concert(
        id: 1,
        name: "Water Bom",
        description: "Hello",
        posterURL: URL(string: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    )
    return PerformanceList(concert: concert, path: .constant(.init()))
}
