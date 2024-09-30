//
//  AppError.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation


/// App All Error
public enum AppError : Error {
    
    /// App 내에서 발생하는 클라이언트 에러
    case ClientFailed(reason:ClientFailureReason, errorMessage:String?)
    
    /// API 호출 에러
    case ApiFailed(reason:ApiFailureReason, errorInfo:ErrorInfo?)
}

/// :nodoc:
extension AppError {
    public init(reason:ClientFailureReason = .Unknown, message:String? = nil) {
        switch reason {
        case .Cancelled:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "user cancelled")
        case .NotSupported:
            self = .ClientFailed(reason: reason, errorMessage: "target app is not installed.")
        case .BadParameter:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "bad parameters.")
        case .TokenNotFound:
            self = .ClientFailed(reason: reason, errorMessage: message ?? "authentication tokens not exist.")
        case .CastingFailed:
            self = .ClientFailed(reason: reason, errorMessage: message ?? "casting failed.")
        case .Unknown:
            self = .ClientFailed(reason: reason, errorMessage:message ?? "unknown error.")
        }
    }
}

/// :nodoc:
extension AppError {
    public init?(response:HTTPURLResponse, data:Data) {
        if 200 ..< 300 ~= response.statusCode { 
            return nil
        }

        if let errorInfo = try? AppJSONDecoder.custom.decode(ErrorInfo.self, from: data) {
            self = .ApiFailed(reason: errorInfo.errorCode, errorInfo:errorInfo)
        }
        else {
            return nil
        }
    }
    

    
    public init(apiFailedMessage:String? = nil) {
        self = .ApiFailed(
            reason: .Unknown,
            errorInfo: ErrorInfo(errorCode: .Unknown, message: apiFailedMessage ?? "Unknown Error")
        )
    }
}

//helper
extension AppError {
    
    public var isClientFailed : Bool {
        if case .ClientFailed = self {
            return true
        }
        return false
    }
    
    public var isApiFailed : Bool {
        if case .ApiFailed = self {
            return true
        }
        return false
    }
    
    
        
    public func getClientError() -> (reason:ClientFailureReason, message:String?) {
        if case let .ClientFailed(reason, message) = self {
            return (reason, message)
        }
        return (ClientFailureReason.Unknown, nil)
    }
        
    public func getApiError() -> (reason:ApiFailureReason, info:ErrorInfo?) {
        if case let .ApiFailed(reason, info) = self {
            return (reason, info)
        }
        return (ApiFailureReason.Unknown, nil)
    }
        
    
    
    public func isInvalidTokenError() -> Bool {
        if case .ApiFailed = self, getApiError().reason == .InvalidAccessToken {
            return true
        }
                
        return false
    }
}

//MARK: - error code enum


/// 클라이언트 에러 종류 입니다.
public enum ClientFailureReason {
    /// 기타 에러
    case Unknown
    
    /// 사용자의 취소 액션 등
    case Cancelled
    
    /// API 요청에 사용할 토큰이 없음
    case TokenNotFound
    
    /// 지원되지 않는 기능
    case NotSupported
    
    /// 잘못된 파라미터
    case BadParameter
        
    /// type casting 실패
    case CastingFailed
}

/// API 서버 에러 종류 입니다.
public enum ApiFailureReason : Int, Codable {
    
    /// 기타 서버 에러
    case Unknown = -9999
    
    /// 기타 서버 에러
    case Internal = -1
    
    /// 잘못된 파라미터
    case BadParameter = -2
    
    /// 존재하지 않은 엔티티
    case EntityNotFound = -3
    
    /// 잘못된 상태값
    case IllegalStatus = -4
    
    
    /// 앱키 또는 토큰이 잘못된 경우. 예) 토큰 만료
    case InvalidAccessToken = -401

    // 접근 권한이 없음
    case AccessDenied = -403
    
    // 이미 선정된 좌석
    case AlreadyChoseSeats = -10
    
}

/// :nodoc:
extension ApiFailureReason {
    public init(from decoder: Decoder) throws {
        self = try ApiFailureReason(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .Unknown
    }
}

