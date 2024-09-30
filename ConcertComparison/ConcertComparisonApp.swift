//
//  ConcertComparisonApp.swift
//  ConcertComparison
//
//  Created by 한현규 on 8/19/24.
//

import SwiftUI
import LogUtil
import User


@main
struct ConcertComparisonApp: App {
    @State
    private var user: User = USER
    
    init(){
        LogSetup.setupLogger()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(user)
        }
    }
}
