//
//  Performance.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation


@Observable
public final class Performance: Identifiable, Hashable{
 
            
    public let id: Int
    public let concertId: Int
    public let mapId: Int
    public let performanceAt: Date
    
    init(response: PerformanceResponse){
        self.id = response.id
        self.concertId = response.concertId
        self.mapId = response.mapId
        self.performanceAt = response.performanceAt
    }
    
    init(id: Int, concertId: Int, locationId: Int, performanceAt: Date) {
        self.id = id
        self.concertId = concertId
        self.mapId = locationId
        self.performanceAt = performanceAt
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Performance, rhs: Performance) -> Bool {
        lhs.id == rhs.id
    }
    
}


