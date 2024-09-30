//
//  ConcertCard.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import SwiftUI
import Kingfisher

struct ConcertCard: View {
    
    private let concert: Concert
    
    init(concert: Concert){
        self.concert = concert
    }
    
    var body: some View {
        KFImage(concert.posterURL)
            .resizable()
            .aspectRatio(3 / 2,contentMode: .fit)
            .overlay{
                TextOverlay(concert: concert)
            }
    }
    
    private struct TextOverlay: View {
        var concert: Concert
        
        var gradient: LinearGradient {
            .linearGradient(
                Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .center)
        }
        
        
        var body: some View {
            ZStack(alignment: .bottomLeading) {
                gradient
                VStack(alignment: .leading) {
                    Text(concert.name)
                        .font(.title)
                        .bold()
                    Text(concert.description)
                }
                .padding()
            }
            .foregroundColor(.white)
        }
    }

}



#Preview {
    let mock = Concert(
        id: 1,
        name: "Waterbom",
        description: "Hello",
        posterURL: URL(string: "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    )
    return ConcertCard(concert: mock)
        .aspectRatio(3 / 2, contentMode: .fit)
}



