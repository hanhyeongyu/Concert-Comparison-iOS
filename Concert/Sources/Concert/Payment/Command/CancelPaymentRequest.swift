//
//  File.swift
//  
//
//  Created by 한현규 on 8/20/24.
//

import Foundation
import Networks

struct CancelPaymentRequest: APIRequest{
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(paymentId: String) {
        self.endpoint = BaseURL.paymentURL.appendingPathComponent("payments/cancel")
        self.method = .post
        self.query = [
            "paymentId": paymentId
        ]
        self.header = [:]
    }
    
    
}
