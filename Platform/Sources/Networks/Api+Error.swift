//
//  Network+Error.swift
//
//
//  Created by 한현규 on 7/28/24.
//

import Foundation
import AppUtil
import Alamofire


extension Api{
    public func getError(error: Error) -> AppError? {
        if let aferror = error as? AFError {
            switch aferror {
            case .responseValidationFailed(let reason):
                switch reason {
                case .customValidationFailed(let error):
                    return error as? AppError
                default:
                    break
                }
            default:
                break
            }
        }
        return nil
    }
    
    public func getRequestRetryFailedError(error:Error) -> AppError? {
        if let aferror = error as? AFError {
            switch aferror {
            case .requestRetryFailed(let retryError, _):
                return retryError as? AppError
            default:
                break
            }
        }
        return nil
    }
}
