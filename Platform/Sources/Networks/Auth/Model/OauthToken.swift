//
//  OauthToken.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation
import AppUtil
import Preference

public struct OAuthToken: Codable {
    
    public let tokenType: String
    public let accessToken: String
    public let expiresIn: Int
    public let refreshToken: String
    public let refreshExpiresIn: Int

    init(tokenType: String, accessToken: String, expiresIn: Int, refreshToken: String, refreshExpiresIn: Int) {
        self.tokenType = tokenType
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
        self.refreshExpiresIn = refreshExpiresIn
    }
    
    public static func shared() -> OAuthToken?{
        PreferenceStorage.shared.token
    }
    
    

    public func refresh(
        completion:@escaping (OAuthToken?, Error?) -> Void
    ) {
                
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        API.send(request,sessionType: .Api) { output, error in
            if let error = error{
                completion(nil, error)
                return
            }
            
            if let newToken = output{
                PreferenceStorage.shared.token = newToken
                completion(newToken, nil)
            }
            
            completion(nil, AppError())
        }
    }
    
    public static func issue(
        id : String ,
        password : String
    ) async throws -> OAuthToken{
        let request = IssueTokenRequest( id: id, password: password)
        let token =  try await API.send(request, sessionType: .Api)
                
        PreferenceStorage.shared.token = token
        
        return token
    }
    
    
}
