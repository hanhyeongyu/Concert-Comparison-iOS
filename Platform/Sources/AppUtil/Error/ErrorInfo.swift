//
//  ErrorInfo.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation




public struct ErrorInfo : Codable {
        
    public let errorCode: ApiFailureReason
    public let message: String
    
    

    public init(errorCode: ApiFailureReason, message: String) {
        self.errorCode = errorCode
        self.message = message
    }
}
