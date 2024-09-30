//
//  ConcertsView.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI

public struct ConcertsView: View {

    @State
    private var concerts: [Concert]
                
    @State
    private var continuationToken: String? = nil
            
    @State
    var path: NavigationPath = .init()
    
    
    public init(){
        concerts = []
    }
    
    public var body: some View {
        NavigationStack(path: $path){
            List{
                ForEach(concerts){ concert in
                    NavigationLink(value: concert) {
                        ConcertCatalogRow(concert: concert)
                    }.onAppear{
                        if concerts.last == concert{
                            Task{
                                try await fetch()
                            }
                        }
                    }
                    
                }
            }
            .toolbar{
                Button {
                    path.append(ReservationsView.tag)
                } label: {
                    Label("Ticket", systemImage: "ticket")
                }
            }
            .navigationDestination(for: String.self){ tag in
                if tag == ReservationsView.tag{
                    ReservationsView()
                }
            }
            .navigationDestination(for: Concert.self) { concert in
                PerformancesView()
                    .environment(concert)
            }
            
            .task {
                try? await fetch()
            }
            
        }
    }

    func fetch() async throws{
        if isEnd(){
            return
        }
        
        let result = try await ConcertApi.shared.concerts(continuationToken)
        self.continuationToken = result.continuationToken
        await MainActor.run {
            self.concerts.append(contentsOf: result.items.map(Concert.init))
        }
    }
    
    
    private func isEnd() -> Bool{
        !concerts.isEmpty && continuationToken == nil
    }
}

#Preview {
    ConcertsView()
}
