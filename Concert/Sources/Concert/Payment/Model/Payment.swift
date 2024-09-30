//
//  Payment.swift
//
//
//  Created by 한현규 on 8/18/24.
//

import Foundation
import Networks
import AppUtil


@Observable
final class Payment: Identifiable,  Hashable{

    var id: UUID
    
    let orderName: String
    
    let amount: Int
    let currency: String
    
    var paymentId: String?
    var paymentKey: String?
    
    
    var status: Status
    
    init(
        orderName: String,
        amount: Int
    ) {
        self.id = UUID()
        self.orderName = orderName
        self.amount = amount
        self.currency = "WON"
        self.paymentId = nil
        self.paymentKey = nil
        self.status = .IDLE
    }
    
  
    
    func payment() async throws{
        try await addPayment()
        try await requestPayment()
        try await confirmPayment()
    }
    
    func addPayment() async throws{
        let request = AddPaymentRequest(amount: amount, currency: currency)
        let response = try await AUTHAPI.send(request)
        
        self.paymentId = response.paymentId
        self.status = .ADDED
    }
    
    func requestPayment() async throws{
        if status != .ADDED || paymentId == nil{
            throw AppError(reason: .Unknown)
        }
        
        let paymentApi = PaymentApi.shared
        let url = try await paymentApi.request(paymentId: paymentId!, amount: amount)
        let paymentKey = paymentApi.paymentKey(url: url)
        
        self.paymentKey = paymentKey
        self.status = .REQUEST
    }
    
    func confirmPayment() async throws{
        if status != .REQUEST || paymentId == nil || paymentKey == nil{
            throw AppError(reason: .Unknown)
        }
        
        let request = ConfirmPaymentRequest(paymentId: paymentId!, paymentKey: paymentKey!, amount: amount, currency: currency)
        _ = try await AUTHAPI.send(request)
        self.status = .CONFIRM        
    }
    

    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Payment, rhs: Payment) -> Bool {
        lhs.id == rhs.id
    }
    
    enum Status{
        case IDLE
        case ADDED
        case REQUEST
        case CONFIRM
        case FAIL
        case CANCEL
    }
    
}
