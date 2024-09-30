//
//  ReservstionApi.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


public final class ReservstionApi{
    
    public static let shared = ReservstionApi(baseURL: BaseURL.reservationURL)
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func reservations() async throws -> ReservationsResponse{
        let request = ReservationsRequest(baseURL: baseURL)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    func reservation(reservationId: String) async throws -> ReservationResponse{
        let request = ReservationRequest(baseURL: baseURL, reservationId: reservationId)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    func addReservation(concertId: Int, performanceId: Int, paymentId: String, ticketIds: [Int]) async throws{
        let request = AddReservationRequest(baseURL: baseURL, concertId: concertId, performanceId: performanceId, paymentId: paymentId, ticketIds: ticketIds)
        _ = try await AUTHAPI.send(request)
    }
    
    
}
