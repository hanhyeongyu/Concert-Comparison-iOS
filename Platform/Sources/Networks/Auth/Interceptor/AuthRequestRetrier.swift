//
//  AuthRequestRetrier.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation
import AppUtil
import Alamofire
import CocoaLumberjackSwift


public class AuthRequestRetrier : RequestInterceptor {
    public typealias Request = Alamofire.Request
    
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    private var isRefreshing = false
    
    private var errorLock = NSLock()
    
    
    public init() {
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        errorLock.lock() ; defer { errorLock.unlock() }
        
        var logString = "request retrier:"
        
        guard let error = API.getError(error: error) else {
            DDLogError("\(logString)\n not handled error -> pass through \n\n")
            completion(.doNotRetry)
            return
        }
        
        switch(error.getApiError().reason) {
        case .InvalidAccessToken:
            
            logString = "\(logString)\n reason:\(error)\n token: \(String(describing: OAuthToken.shared()))"
            DDLogError("\(logString)\n\n")
            
            guard let token = OAuthToken.shared() else{
                let apiError = AppError(reason: .TokenNotFound)
                DDLogError(" refresh token not exist. retry aborted.\n\n")
                DDLogError(" should not refresh: \(apiError)  -> pass through \n")
                completion(.doNotRetryWithError(apiError))
                return
            }
            
            if !isRefreshing {
                isRefreshing = true
                //SdkLog.d("<<<<<<<<<<<<<< start token refresh\n request: \(String(describing:request))\n\n")
                token.refresh { [unowned self] (token, error) in
                    
                    if let error = error {
                        //token refresh failure.
                        DDLogError("\(logString) refreshToken error: \(error). retry aborted.\n request: \(request) \n\n")
                        
                        //pending requests all cancel
                        self.requestsToRetry.forEach {
                            $0(.doNotRetryWithError(error))
                        }
                    }else {
                        //token refresh success.
                        DDLogDebug(">>>>>>>>>>>>>> refreshToken success\n request: \(request) \n\n")
                        
                        //proceed all pending requests.
                        self.requestsToRetry.forEach {
                            $0(.retry)
                        }
                    }
                    
                    self.requestsToRetry.removeAll() //reset all stored completion
                    self.isRefreshing = false
                }
            }
        default:
            DDLogError("\(logString)\n reason:\(error)\n not handled error -> pass through \n\n")
            completion(.doNotRetryWithError(error))
        }
        
    }

}
