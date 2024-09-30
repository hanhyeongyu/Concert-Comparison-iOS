//
//  Seat.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation

@Observable
final class Seat: Hashable, Decodable{
    
    let id: Int
    let mapId: Int
    let seatInfo: String
    let rowNum: Int
    let seatNum: Int
    let posTop: Int
    let posLeft: Int
    
    init(id: Int, mapId: Int, seatInfo: String, rowNum: Int, seatNum: Int, posTop: Int, posLeft: Int) {
        self.id = id
        self.mapId = mapId
        self.seatInfo = seatInfo
        self.rowNum = rowNum
        self.seatNum = seatNum
        self.posTop = posTop
        self.posLeft = posLeft        
    }

    
    func title() -> String{
        return "\(Seat.rowTable[rowNum])\(seatNum)"
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Seat, rhs: Seat) -> Bool {
        lhs.id == rhs.id
    }
}


extension Seat{
    private static var rowTable: [Character] = {
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value

        let letters: [Character] = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i)!)
        }
        return letters
    }()
}
