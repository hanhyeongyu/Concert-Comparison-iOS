//
//  File.swift
//  
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks

struct PaymentRequest: APIRequest{
    typealias Output = PaymentResponse
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(paymentId: String) {
        self.endpoint = BaseURL.paymentURL.appendingPathComponent("/payments")
        self.method = .get
        self.query = [
            "paymentId": paymentId
        ]
        self.header = [:]
    }
    
    
}


struct PaymentResponse: Decodable{
    let paymentId: String
    let userId: Int
    let paymentKey: String?
    let amount: Int
    let currency: String
    let status: Status
    
    enum Status: String, Decodable{
        case IDLE
        case ADDED
        case REQUEST
        case CONFIRM
        case FAIL
        case CANCEL
    }
}
