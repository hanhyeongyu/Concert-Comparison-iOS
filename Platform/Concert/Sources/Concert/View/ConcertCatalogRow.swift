//
//  ConcertCatalogRow.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI

public struct ConcertCatalogRow: View {
    
    private let concert: Concert
    
    public init(concert: Concert){
        self.concert = concert
    }
    
    public var body: some View {
        VStack{
            Text(concert.name)
            Text(concert.description)
        }
    }
}



#Preview {
    let mock = Concert(id: 1, name: "Waterbom", description: "Hello")
    return ConcertCatalogRow(concert: mock)
}
