//
//  Seat.swift
//
//
//  Created by 한현규 on 8/14/24.
//

import Foundation

@Observable
public class Seat: Cell{

    private static var rowTable: [Character] = {
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value

        let letters: [Character] = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i)!)
        }
        return letters
    }()
    
    
    let id: Int
    let mapId: Int
    let seatInfo: String
    let rowNum: Int
    let seatNum: Int
    var isSelected: Bool
    
    var isEnable: Bool
    var ticketId: Int?
    
    init(seatResponse: SeatsResponse) {
        self.id = seatResponse.id
        self.mapId = seatResponse.mapId
        self.seatInfo = seatResponse.seatInfo
        self.rowNum = seatResponse.rowNum
        self.seatNum = seatResponse.seatNum
        self.isSelected = false
        self.isEnable = false
        self.ticketId = nil
        
        super.init(posTop: seatResponse.posTop, posLeft: seatResponse.posLeft)
    }
    
    init(id: Int, mapId: Int, seatInfo: String, rowNum: Int, seatNum: Int, posTop: Int, posLeft: Int) {
        self.id = id
        self.mapId = mapId
        self.seatInfo = seatInfo
        self.rowNum = rowNum
        self.seatNum = seatNum
        self.isSelected = false
        self.isEnable = false
        
        super.init(posTop: posTop, posLeft: posLeft)
    }
    
    public func title() -> String{
        return "\(Seat.rowTable[rowNum])\(seatNum)"
    }
    

    func toggle(){
        if !isEnable{
            return
        }
        
        self.isSelected.toggle()
    }
    
    
    
}
