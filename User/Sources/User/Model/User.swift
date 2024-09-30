//
//  User.swift
//
//
//  Created by 한현규 on 7/26/24.
//

import Foundation
import SwiftUI
import Networks

public let USER = User.shared

@Observable
public final  class User{
    
    public static let shared = User()
    
    public private(set) var isSignIn: Bool = false
            
    
    public init(){
        isSignIn = OAuthToken.shared() != nil
    }

    
    public func signIn(email: String, password: String) async throws{
        _  = try await OAuthToken.issue(id: email, password: password)
        await MainActor.run {
            isSignIn = OAuthToken.shared() != nil
        }
    }
    
    public func signup(email: String, password: String) async throws{
        let requset = SignupRequest(email: email,password: password)
        _ = try await API.send(requset, sessionType: .Api)
    }
}

