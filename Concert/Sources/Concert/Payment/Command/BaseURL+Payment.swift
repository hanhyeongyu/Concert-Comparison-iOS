//
//  BaseURL+Payment.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks

extension BaseURL{
    static var paymentURL: URL{
        URL(string: "http://localhost:8080")!
    }
}
