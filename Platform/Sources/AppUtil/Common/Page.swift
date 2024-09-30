//
//  Page.swift
//
//
//  Created by 한현규 on 8/20/24.
//

import Foundation


public struct Page<T: Decodable>: Decodable{
    public let items: [T]
    public let continuationToken: String?
    
    public init(items: [T], continuationToken: String?) {
        self.items = items
        self.continuationToken = continuationToken
    }
        
     public func map<R>(_ transform: (T) -> R) -> Page<R> {
         return Page<R>(
             items: items.map(transform),
             continuationToken: continuationToken
         )
     }
}
