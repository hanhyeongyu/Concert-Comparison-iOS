//
//  PaymentApi.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


final class PaymentApi{
    
    public static let shared = PaymentApi()
    
    init(){
        
    }
    
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
        
    
    func paymentKey(url: URL) -> String{
        let key = "paymentKey"
        return queryItems(url: url).first { $0.name == key
        }!.value!
    }
    
    private func queryItems(url : URL) -> [URLQueryItem]{
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        return items
    }
    

    
    
//    func confirm(paymentId: String, paymentKey: String, amount: Int) async throws{
//        let request = ConfirmPaymentRequest(
//            paymentId: paymentId,
//            paymentKey: paymentKey,
//            amount: amount
//        )
//        _ = try await AUTHAPI.send(request)
//    }
    
    
}
