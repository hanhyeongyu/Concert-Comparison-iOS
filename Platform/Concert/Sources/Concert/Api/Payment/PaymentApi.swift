//
//  PaymentApi.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


class PaymentApi{
    
    public static let shared = PaymentApi(baseURL: BaseURL.paymentURL)
    
    public let baseURL: URL

    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func payment(_ paymentId: String) async throws -> PaymentResponse{
        let request = PaymentRequest(baseURL: baseURL, paymentId: paymentId)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    func add(_ amount: Int) async throws -> AddPaymentResponse{
        let request = AddPaymentRequest(baseURL: baseURL, amount: amount)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    
    //PG Server
    func request(paymentId: String,  amount: Int) async throws -> URL{
        let mockPaymentKey = UUID()
        
        let baseURL = URL(string: "https://store.com")!
        let url = baseURL.appendingPathComponent("/success")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = [
            URLQueryItem(name: "paymentKey", value: mockPaymentKey.uuidString),
            URLQueryItem(name: "orderld", value: paymentId),
            URLQueryItem(name: "amount", value: String(amount))
        ]

        return components.url!
    }
    
    func confirm(paymentId: String, paymentKey: String, amount: Int) async throws{
        let request = ConfirmPaymentRequest(
            baseURL: baseURL,
            paymentId: paymentId,
            paymentKey: paymentKey,
            amount: amount
        )
        _ = try await AUTHAPI.send(request)
    }
    
    
}
