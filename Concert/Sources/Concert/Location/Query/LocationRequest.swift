//
//  LocationRequest.swift
//
//
//  Created by 한현규 on 8/22/24.
//

import Foundation
import Networks

struct LocationRequest: APIRequest{
    typealias Output = Location
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(locationId: Int) {
        self.endpoint = BaseURL.locationURL.appendingPathComponent("/locations/\(locationId)")
        self.method = .get
        self.query = [:]
        self.header = [:]
    }

}
