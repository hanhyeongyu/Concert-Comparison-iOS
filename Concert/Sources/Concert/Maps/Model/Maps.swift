//
//  Maps.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import SwiftUI
import Networks


@Observable
final class Maps: Decodable{
        
    let id: Int
    let locationId: Int
    let width: Int
    let height: Int
    let seats: [Seat]
    
    init(id: Int, locationId: Int, width: Int, height: Int, seats: [Seat]) {
        self.id = id
        self.locationId = locationId
        self.width = width
        self.height = height
        self.seats = seats
    }
    
}
