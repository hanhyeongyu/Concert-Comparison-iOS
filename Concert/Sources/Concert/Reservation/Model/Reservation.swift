//
//  Reservation.swift
//
//
//  Created by 한현규 on 8/20/24.
//

import Foundation
import AppUtil
import Networks


@Observable
final class Reservation: Identifiable, Hashable, Decodable{
    
    let id: Int
    let reservationId: UUID
    let userId: Int
    let concertId: Int
    let performanceId: Int
    let locationId: Int
    let mapsId: Int
    let paymentId: UUID
    let status: Status
    let reservationAt: Date
    let concertName: String
    let performanceName: String
    let performanceDate: Date
    let locationName: String
    let numberOfTickets: Int
    let totalPrice: Int
    let posterURL: URL?
    
    enum Status: String, Decodable{
        case RESERVATION
        case CANCEL
    }
    
    init(id: Int, reservationId: UUID, userId: Int, concertId: Int, performanceId: Int, locationId: Int, mapsId: Int, paymentId: UUID, status: Status, reservationAt: Date, concertName: String, performanceName: String, performanceDate: Date, locationName: String, numberOfTickets: Int, totalPrice: Int, posterURL: URL?) {
        self.id = id
        self.reservationId = reservationId
        self.userId = userId
        self.concertId = concertId
        self.performanceId = performanceId
        self.locationId = locationId
        self.mapsId = mapsId
        self.paymentId = paymentId
        self.status = status
        self.reservationAt = reservationAt
        self.concertName = concertName
        self.performanceName = performanceName
        self.performanceDate = performanceDate
        self.locationName = locationName
        self.numberOfTickets = numberOfTickets
        self.totalPrice = totalPrice
        self.posterURL = posterURL
    }
    
    static func addReservation(
        concertId: Int,
        performanceId: Int,
        paymentId: String,
        ticketIds: [Int]
    ) async throws -> Reservation{
        let request = AddReservationRequest(
            concertId: concertId,
            performanceId: performanceId,
            paymentId: paymentId,
            ticketIds: ticketIds
        )
        return  try await AUTHAPI.send(request)        
    }
    
    static func reservations(continuationToken: String?) async throws -> Page<Reservation>{
        let request = ReservationsRequest(continuationToken: continuationToken)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    
    func items() async throws -> [ReservationItem]{
        let request = ReservationItemsRequest(reservationId: reservationId.uuidString)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Reservation, rhs: Reservation) -> Bool {
        lhs.id == rhs.id
    }
    
}
