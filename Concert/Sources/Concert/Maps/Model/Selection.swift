//
//  Selection.swift
//
//
//  Created by 한현규 on 8/21/24.
//

import Foundation
import Networks


@Observable
final class SeatSelection{
        
    var selected: Set<Seat>
    
    init() {
        self.selected = []
    }
    
    func toogle(seat: Seat){
        if selected.contains(seat){
            selected.remove(seat)
        }else{
            selected.insert(seat)
        }
    }
    
    
    func isSelect(seat: Seat) -> Bool{
        selected.contains(seat)
    }        
        
    func ticketIds() -> [Int]{
        return selected.map { $0.id }
    }
    
}

