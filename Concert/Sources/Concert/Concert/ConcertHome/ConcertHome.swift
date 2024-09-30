//
//  ConcertHome.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import AppUtil
import UIUtil
import LogUtil

public struct ConcertHome: View {
    
    @State
    private var concerts: [Concert]
    
    @State
    private var ranks: [Concert]
    
    @State
    private var continuationToken: String? = nil
    
    @State
    var path: NavigationPath = .init()
    
    
    public init(){
        concerts = []
        ranks = []
    }
    
    public var body: some View {
        NavigationStack(path: $path){
            VStack{
                List {
                    if !concerts.isEmpty{
                        PageView(
                            pages: concerts.shuffled()
                                .map{ concert in
                                    ConcertCard(concert: concert).onTapGesture {
                                        path.append(concert)
                                    }
                                }
                        )
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    ScrollView(.horizontal){
                        LazyHStack{
                            ForEach(ranks){ concert in
                                ConcertRow(concert: concert, rank: ranks.firstIndex(of: concert)! + 1)
                                    .onTapGesture {
                                        path.append(concert)
                                    }
                            }
                        }
                        .padding()
                    }
                    .aspectRatio(2 / 1, contentMode: .fit)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Concerts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Concert.self) { concert in
                PerformanceCalendar(concert: concert, path: $path)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: Text("Alert")
                    ) {
                        Button {} label: {
                            Label("bell", systemImage: "bell")
                        }
                    }
                    .tint(.primary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: Text("Setting")
                    ) {
                        Button {} label: {
                            Label("Setting", systemImage: "line.3.horizontal")
                        }
                    }
                    .tint(.primary)
                }
            }
            .task {
                do{
                    if !isLast(){
                        self.concerts = try await Concert.concerts(continuationToken: continuationToken).items
                    }
                }catch{
                    Log.e("Failed to fetch concerts: \(error)")
                }
            }
            .task {
                do{
                    ranks = try await Concert.ranks()
                }catch{
                    Log.e("Failed to fetch concerts ranks: \(error)")
                }
            }
        }
    }
        
    
    private func isLast() -> Bool{
        !concerts.isEmpty && continuationToken == nil
    }
}

#Preview {
    ConcertHome()
}
