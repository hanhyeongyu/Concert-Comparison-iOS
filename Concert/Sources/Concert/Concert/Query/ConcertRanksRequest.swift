//
//  ConcertRanksRequest.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import Foundation


import Foundation
import AppUtil
import Networks


struct ConcertRanksRequest: APIRequest{
    typealias Output = Page<Concert>
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init() {
        self.endpoint = BaseURL.concertURL.appendingPathComponent("/concerts")
        self.method = .get
        self.query = [:]
        self.header = [:]
    }
    
}
