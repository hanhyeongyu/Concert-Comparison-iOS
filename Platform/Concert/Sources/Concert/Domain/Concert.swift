//
//  Concert.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import SwiftUI

@Observable
public final class Concert: Identifiable, Hashable, Equatable{
    
    public let id: Int
    public let name: String
    public let description: String
    
    public var performances: [Performance]
    
    init(response: ConcertResponse){
        self.id = response.id
        self.name = response.name
        self.description = response.description
        self.performances = []
    }
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
        self.performances = []
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func ==(lhs: Concert, rhs: Concert) -> Bool{
        return lhs.id == rhs.id
    }
    
    func fetchPerformance() async throws{
        let result = try await ConcertApi.shared.performances(id)
            .map(Performance.init)
        self.performances = result
    }
}
