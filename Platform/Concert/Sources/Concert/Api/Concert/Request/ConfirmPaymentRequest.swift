//
//  ConfirmPaymentRequest.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks


struct ConfirmPaymentRequest: APIRequest{
    typealias Output = ConfirmPaymentResponse

    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
//    val paymentId: UUID,
//           val paymentKey: String,
//           val amount: Long,
//           val currency: String
    
    init(baseURL: URL, paymentId: String, paymentKey: String, amount: Int) {
        self.endpoint = baseURL.appendingPathComponent("payments/confirm")
        self.method = .post
        self.query = [
            "paymentId": paymentId,
            "paymentKey": paymentKey,
            "amount": amount,
            "currency": "WON"
        ]
        self.header = [
            "Content-Type": "application/json"
        ]
    }
    
}



struct ConfirmPaymentResponse: Decodable{
    let id: Int
    let userId: Int
    let paymentKey: String
    let amount: Int
    let currency: String
    let status: Status
    
    enum Status: String, Decodable{
        case PAYMENT
        case CANCEL
    }
}

