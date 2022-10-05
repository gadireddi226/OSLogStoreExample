//
//  Extension+OSLogEntry.swift
//  Approver
//
//  Created by Gadireddi Erik on 04.10.2022.
//  Copyright © 2022 Avast. All rights reserved.
//

import OSLog

extension OSLogEntryLog {
    open override var description: String {
        return  "[\(date.formatted(date: .numeric, time: .standard))] [\(level)] [\(category)] \(composedMessage)"
    }
}
