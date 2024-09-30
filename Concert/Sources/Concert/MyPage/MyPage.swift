//
//  MyPage.swift
//  Concert
//
//  Created by 한현규 on 9/26/24.
//

import SwiftUI

public struct MyPage: View {
    
    
    public init(){}
    
    public var body: some View {
        NavigationStack {
            ReservationList()
                .navigationTitle("Reservations")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden(false)
        }
    }
}

#Preview {
    MyPage()
}
