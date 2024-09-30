//
//  AppCoder.swift
//  Authenticator
//
//  Created by 한현규 on 2023/08/01.
//

import Foundation


public class AppJSONEncoder : JSONEncoder {
    public static var `default`: AppJSONEncoder { return AppJSONEncoder() }
    public static var `custom`: AppJSONEncoder { return AppJSONEncoder(useCustomStrategy:true) }
    public static var `customDate`: AppJSONEncoder { return AppJSONEncoder(useCustomStrategy:true, useDateFormatterStrategy:true) }
        
   init(useCustomStrategy:Bool = false, useDateFormatterStrategy:Bool = false) {
        super.init()
        if (useCustomStrategy) {
            self.keyEncodingStrategy = .convertToSnakeCase
        }
       
       if (useDateFormatterStrategy) {
           self.keyEncodingStrategy = .convertToSnakeCase
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
           formatter.locale = Locale.current
           formatter.timeZone = TimeZone(abbreviation: "UTC")
           self.dateEncodingStrategy = .formatted(formatter)
       }
    }
}



public class AppJSONDecoder : JSONDecoder {
    public static var `default`: AppJSONDecoder { return AppJSONDecoder() }
    public static var `custom`: AppJSONDecoder { return AppJSONDecoder(useCustomStrategy:true) }
    public static var `customIso8601Date`: AppJSONDecoder { return AppJSONDecoder(useCustomStrategy:true, dateStrategy: .iso8601) }
    public static var `customSecondsSince1970`: AppJSONDecoder { return AppJSONDecoder(useCustomStrategy:true, dateStrategy: .secondsSince1970) }
    
    init(useCustomStrategy:Bool = false, dateStrategy: DateDecodingStrategy? = nil) {
        super.init()
        if (useCustomStrategy) {
            self.keyDecodingStrategy = .convertFromSnakeCase
        }
        if let dateStrategy = dateStrategy {
            self.dateDecodingStrategy = dateStrategy
        }
    }
}


extension AppJSONDecoder{    
    public static var `springIso8601Date`: AppJSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return AppJSONDecoder(useCustomStrategy:true, dateStrategy: .formatted(formatter))
    }
}
