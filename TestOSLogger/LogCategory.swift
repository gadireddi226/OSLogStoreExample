//
//  LogCategory.swift
//  Approver
//
//  Created by Gadireddi Erik on 04.10.2022.
//  Copyright © 2022 Avast. All rights reserved.
//

import OSLog

enum LogsCategory: CaseIterable, CustomStringConvertible {
    case all
    case info
    case error
    case debug
    
    var description: String {
        switch self {
        case .all:
            return "All"
        case .info:
            return "Info"
        case .error:
            return "Error"
        case .debug:
            return "Debug"
        }
    }
    
    func logLevels() -> [OSLogEntryLog.Level] {
        var levels: [OSLogEntryLog.Level] = []
        switch self {
        case .all:
            levels = [.undefined, .debug, .info, .notice, .error, .fault]
            return levels
        case .info:
            levels = [.undefined, .info, .notice]
            return levels
        case .error:
            levels = [.error, .fault]
            return levels
        case .debug:
            levels = [.debug]
            return levels
        }
    }
}
