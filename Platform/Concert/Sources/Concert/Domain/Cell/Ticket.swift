//
//  File.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import Foundation



struct Ticket{
    let id: Int
    let performanceId: Int
    let mapId: Int
    let seatId: Int
    let enable: Bool
    
    init(response: TicketsResponse){
        self.id = response.id
        self.performanceId = response.performanceId
        self.mapId = response.mapId
        self.seatId = response.seatId
        self.enable = response.enable
    }
    
    init(id: Int, performanceId: Int, mapId: Int, seatId: Int, enable: Bool) {
        self.id = id
        self.performanceId = performanceId
        self.mapId = mapId
        self.seatId = seatId
        self.enable = enable
    }
}
