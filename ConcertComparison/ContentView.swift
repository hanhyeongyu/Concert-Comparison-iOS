//
//  ContentView.swift
//  ConcertComparison
//
//  Created by 한현규 on 8/19/24.
//

import SwiftUI
import User
import Concert

struct ContentView: View {
    
    @Environment(User.self)
    private var user: User
    
    var body: some View {
        TabView{
            ConcertHome()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            if user.isSignIn{
                MyPage()
                    .tabItem {
                        Image(systemName: "person")
                        Text("MyPage")
                    }
            }else{
                SignIn()
                    .tabItem {
                        Image(systemName: "person")
                        Text("MyPage")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(User())
}
