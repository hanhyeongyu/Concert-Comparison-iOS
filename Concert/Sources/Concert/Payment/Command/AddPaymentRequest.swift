//
//  AddPaymentRequest.swift
//  
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks


struct AddPaymentRequest: APIRequest{
    typealias Output = AddPaymentResponse

    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(amount: Int, currency: String) {
        self.endpoint = BaseURL.paymentURL.appendingPathComponent("payments")
        self.method = .post
        self.query = [
            "amount": amount,
            "currency": currency
        ]
        self.header = [:]
    }
    
    
}




struct AddPaymentResponse: Decodable{
    let paymentId: String
    let userId: Int
    let paymentKey: String?
    let amount: Int
    let currency: String
    let status: Status
    
    enum Status: String, Decodable{
        case REQUEST
        case CONFIRM
        case FAIL
        case CANCEL
    }
}

