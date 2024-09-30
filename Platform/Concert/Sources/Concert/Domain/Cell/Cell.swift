//
//  Cell.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import Foundation



public class Cell: Hashable{
    var posTop: Int
    var posLeft: Int
    
    init(posTop: Int, posLeft: Int) {
        self.posTop = posTop
        self.posLeft = posLeft
    }
    
    static func emptyCell(posTop: Int, posLeft: Int) -> EmptyCell{
        EmptyCell(posTop: posTop, posLeft: posLeft)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(posTop)
        hasher.combine(posLeft)
    }
    
    public static func ==(lhs:  Cell, rhs:  Cell) -> Bool{
        return lhs.posLeft == rhs.posLeft && lhs.posTop == rhs.posTop
    }
}

