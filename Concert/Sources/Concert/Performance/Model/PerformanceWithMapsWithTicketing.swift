//
//  PerformanceMaps.swift
//  Concert
//
//  Created by 한현규 on 9/26/24.
//

import Foundation


struct PerformanceMaps: Hashable{

    let performance: Performance
    let maps: Maps
    let tickets: [Ticket]

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(performance.id)
    }
    
    static func == (lhs: PerformanceMaps, rhs: PerformanceMaps) -> Bool {
        lhs.performance.id == rhs.performance.id
    }
    
    
}
