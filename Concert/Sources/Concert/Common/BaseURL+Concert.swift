//
//  BaseURL+Concert.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation
import Networks

extension BaseURL{
    static var concertURL: URL{
        URL(string: "http://localhost:8080")!
    }
    
    static var performanceURL: URL{
        URL(string: "http://localhost:8080")!
    }
    
    static var locationURL: URL{
        URL(string: "http://localhost:8080")!
    }
    
    static var ticketURL: URL{
        URL(string: "http://localhost:8080")!
    }
    
    static var reservationURL: URL{
        URL(string: "http://localhost:8080")!
    }
}
