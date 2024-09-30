//
//  ConfirmPaymentRequest.swift
//
//
//  Created by 한현규 on 8/16/24.
//

import Foundation
import Networks


struct ConfirmPaymentRequest: APIRequest{
    typealias Output = Empty

    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    

    init(paymentId: String, paymentKey: String, amount: Int, currency: String) {
        self.endpoint = BaseURL.paymentURL.appendingPathComponent("payments/confirm")
        self.method = .post
        self.query = [
            "paymentId": paymentId,
            "paymentKey": paymentKey,
            "amount": amount,
            "currency": currency
        ]
        self.header = [:]
    }
    
}
