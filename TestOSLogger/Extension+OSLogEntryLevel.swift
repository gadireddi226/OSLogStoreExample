//
//  Extension+OSLogEntryLevel.swift
//  Approver
//
//  Created by Gadireddi Erik on 30.09.2022.
//  Copyright © 2022 Avast. All rights reserved.
//

import OSLog

extension OSLogEntryLog.Level: CustomStringConvertible {
    public var description: String {
        switch self {
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .notice:
            return "notice"
        case .error:
            return "error"
        case .fault:
            return "fault"
        case .undefined:
            return "undefined"
        @unknown default:
            return "undefined"
        }
    }
}
