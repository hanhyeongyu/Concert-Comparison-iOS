//
//  Location.swift
//
//
//  Created by 한현규 on 8/22/24.
//

import Foundation
import Networks

final class Location: Decodable{
    let id: Int
    let name: String
    let address: Address
    
    init(id: Int, name: String, address: Address) {
        self.id = id
        self.name = name
        self.address = address
    }
    
    
    static func location(locationId: Int) async throws -> Location{
        let request = LocationRequest(locationId: locationId)
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
}


struct Address: Decodable{
    let city: String
    let street: String
    let zipCode: String
    
    
    init(city: String, street: String, zipCode: String) {
        self.city = city
        self.street = street
        self.zipCode = zipCode
    }
}
