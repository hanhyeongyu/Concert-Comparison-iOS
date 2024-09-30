//
//  Performance.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks

@Observable
final class Performance: Identifiable, Hashable, Decodable{
 
            
    let id: Int
    let concertId: Int
    let mapId: Int
    let name: String
    let performanceAt: Date
    let location: Location
    
    
    init(id: Int, concertId: Int, mapId: Int, name: String, performanceAt: Date, location: Location) {
        self.id = id
        self.concertId = concertId
        self.mapId = mapId
        self.name = name
        self.performanceAt = performanceAt
        self.location = location
    }
    
    
    var maps: Maps{
        get async throws{
            let request = MapsRequest(mapsId: mapId)
            let response = try await API.send(request, sessionType: .Api)
            return response
        }
    }
    

    var tickets: [Ticket]{
        get async throws{
            let request = TicketsRequest(performanceId: id)
            let response = try await API.send(request, sessionType: .Api)
            return response
        }
    }
 
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Performance, rhs: Performance) -> Bool {
        lhs.id == rhs.id
    }
    
}


