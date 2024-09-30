//
//  ConcertApi.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks


final class ConcertApi{
    
    public let baseURL: URL
    
    public static let shared = ConcertApi(baseURL: BaseURL.concertURL)
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
 
    func concerts(_ continuationToken: String? = nil) async throws -> ConcertsResponse{
        let request = ConcertsRequest(
            baseURL: baseURL,
            continuationToken: continuationToken
        )
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    func performances(_ concertId: Int) async throws -> [PerformanceResponse]{
        let request = PerformancesRequest(
            baseURL: baseURL,
            concertId: concertId
        )
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    func maps(_ mapsId: Int) async throws -> MapsResponse{
        let request = MapsRequests(baseURL: baseURL, mapsId: mapsId)
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    func seats(_ mapsId: Int) async throws -> [SeatsResponse]{
        let request = SeatsRequest(baseURL: baseURL, mapId: mapsId)
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    func tickets(_ performanceId: Int) async throws -> [TicketsResponse]{
        let request = TicketsRequest(baseURL: baseURL, performanceId: performanceId)
        let response = try await API.send(request, sessionType: .Api)
        return response
    }
    
    
    func selectTickets(_ ticketIds: [Int]) async throws{
        let request = SelectTicketsRequest(baseURL: baseURL, ticketIds: ticketIds)
        _ =  try await AUTHAPI.send(request)
    }
    


    func issueTickets(ticketIds: [Int]) async throws{
        let request = IssueTicketsRequest(baseURL: baseURL, ticketIds: ticketIds)
        _ = try await AUTHAPI.send(request)
    }
}
