//
//  Empty.swift
//
//
//  Created by 한현규 on 8/8/24.
//

import Foundation
import Alamofire

public struct Empty: Codable, Sendable {
    /// Static `Empty` instance used for all `Empty` responses.
    public static let value = Empty()
}

extension Empty: EmptyResponse {
    public static func emptyValue() -> Empty {
        value
    }
}
