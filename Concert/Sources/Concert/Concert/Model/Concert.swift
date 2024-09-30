//
//  Concert.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import AppUtil
import Networks
import SwiftUI

@Observable
final class Concert: Identifiable, Hashable, Decodable{
    
    let id: Int
    let name: String
    let description: String
    let posterURL: URL?

    
    init(id: Int, name: String, description: String, posterURL: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.posterURL = posterURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Concert, rhs: Concert) -> Bool{
        return lhs.id == rhs.id
    }
    
    
    var performances: [Performance]{
        get async throws{
            let request = PerformancesRequest(concertId: id)
            let response =  try await API.send(request, sessionType: .Api)
            return response
        }
    }
            
    static func concerts(continuationToken: String?) async throws  -> Page<Concert>{
        let request = ConcertsRequest(continuationToken: continuationToken)
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    static func ranks() async throws  -> [Concert]{
        let request = ConcertRanksRequest()
        let response = try await API.send(request, sessionType: .Api).items
        return response
    }
}
