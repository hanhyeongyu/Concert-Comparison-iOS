//
//  LogSetup.swift
//
//
//  Created by 한현규 on 7/27/24.
//

import Foundation
import CocoaLumberjack


public class LogSetup{
    
    public static func setupLogger() {
        let consoleLogger = DDOSLogger.sharedInstance   // console logger
        consoleLogger.logFormatter = LogFormatter()

        let fileLogger: DDFileLogger = DDFileLogger()   // File Logger
        fileLogger.logFormatter = LogFormatter()
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.maximumFileSize = 1 * 1024 * 1024
        fileLogger.logFileManager.maximumNumberOfLogFiles = 4
        
        //let crashlyticsLogger = DDCrashlyticsLogger()   //Crashtics Logger
        //crashlyticsLogger.logFormatter = LogFormatter()
        
        DDLog.add(consoleLogger)
        DDLog.add(fileLogger)
        //DDLog.add(crashlyticsLogger)
                
        //#if DEBUG
        //        let consoleLogger = DDOSLogger.sharedInstance
        //        consoleLogger.logFormatter = RoutineLogFormatter()
        //        DDLog.add(consoleLogger)            // console logger
        //#else
        //        let fileLogger: DDFileLogger = DDFileLogger()   // File Logger
        //        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        //        fileLogger.maximumFileSize = 1 * 1024 * 1024
        //        fileLogger.logFileManager.maximumNumberOfLogFiles = 4
        //
        //        let crashlyticsLogger = DDCrashlyticsLogger()   //Crashtics Logger
        //
        //        DDLog.add(fileLogger)
        //        DDLog.add(crashlyticsLogger)
        //
        //#endif
    }


}


