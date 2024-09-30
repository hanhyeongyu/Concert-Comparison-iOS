//
//  ConcertRow.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import Kingfisher

struct ConcertRow: View {
    
    private let concert: Concert
    private let rank: Int
    
    init(concert: Concert, rank: Int){
        self.concert = concert
        self.rank = rank
    }
    
    var body: some View {
        KFImage(concert.posterURL)
            .resizable()            
            .aspectRatio(2 / 3,contentMode: .fit)
            .overlay{
                TextOverlay(concert: concert, rank: rank)
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
    
    private struct TextOverlay: View {
        var concert: Concert
        var rank: Int
        
        var gradient: LinearGradient {
            .linearGradient(
                Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .center)
        }        
        
        var body: some View {
            ZStack(alignment: .leading) {
                gradient
                VStack(alignment: .leading) {
                    
                    Text("\(rank)")
                        .font(.title)
                        .fontWeight(.bold)
                        .italic()
                    
                    Spacer()
                    
                    Text(concert.name)
                        .font(.caption)
                        .bold()
                    Text(concert.description)
                        .font(.caption2)
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
    return ConcertRow(concert: mock, rank: 1)
        .frame(width: 150.0)
}

