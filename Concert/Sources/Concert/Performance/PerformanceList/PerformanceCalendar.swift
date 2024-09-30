//
//  SwiftUIView.swift
//
//
//  Created by 한현규 on 8/22/24.
//

import SwiftUI
import AppUtil

struct PerformanceCalendar: View {
    
    private var concert: Concert
    
    @State
    private var performances: [Performance]
            
    @State
    private var selection: CalendarView.Selection
    
    @State
    private var allowedDates: Set<Date>
    
    @Binding
    private var path: NavigationPath
                    
    
    init(concert: Concert, path: Binding<NavigationPath>){
        self.concert = concert
        self._path = path
        self.performances = []
        self.allowedDates = .init()
        self.selection = CalendarView.Selection()
    }
    
    
    var body: some View {        
        if !performances.isEmpty{
            
            VStack{
                CalendarView(
                    allowedDates: $allowedDates,
                    dateSelected: $selection
                )
                .aspectRatio(1, contentMode: .fit)
                
                
                Spacer()
                
                Divider()
                
                List(
                    performances.filter{ Calendar.current.startOfDay(for: $0.performanceAt) == selection.current?.date }
                ){ performance in
                    Button {
                        performanceDidTap(performance: performance)
                    } label: {
                        PerformanceRow(performance: performance)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle(concert.name)
            .toolbar(.hidden, for: .tabBar)
            .navigationDestination(for: PerformanceMaps.self){ performanceMaps in
                return MapsGrid(
                    concert: concert,
                    performance: performanceMaps.performance,
                    maps: performanceMaps.maps,
                    tickets: performanceMaps.tickets,
                    path: $path
                )
            }
        }else{
            ProgressView()
                .task {
                    do{
                        self.performances = try await concert.performances
                        self.allowedDates = Set(
                            self.performances.map{
                                Calendar.current.startOfDay(for: $0.performanceAt)
                            }
                        )
                    }catch{
                        
                    }
                }
                .navigationTitle(concert.name)
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
    return PerformanceCalendar(
        concert: concert,
        path: .constant(.init())
    )
}
