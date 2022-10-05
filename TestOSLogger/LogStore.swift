//
//  LogStore.swift
//  Approver
//
//  Created by Gadireddi Erik on 27.09.2022.
//  Copyright © 2022 Avast. All rights reserved.
//

import OSLog
import Foundation

@MainActor final class LogStore: ObservableObject {
    
    // MARK: - Tracking
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LogStore.self)
    )
    
    let store: OSLogStore = try! OSLogStore(scope: .currentProcessIdentifier)
    
    // MARK: - Published properties
    @Published private(set) var entries: [OSLogEntryLog] = []
    @Published var category: LogsCategory = .all
    @Published var state: State = .ready
    @Published var exportShown = false
    
    // MARK: - Computed properties
    var logs: [String] {
        return entries.map { $0.description }
    }
    
    var selectedLogs: [String] {
        return entries
            .filter {
                return category.logLevels().contains($0.level)
            }
            .map { $0.description }
    }
    
    // MARK: functions
    func export() async throws -> Void {
        do {
            let store = try OSLogStore(scope: .currentProcessIdentifier)
            let date = Date().addingTimeInterval(-24 * 3600)
            let position = store.position(date: date)
            /// It seems to not work correctly due to missing logs when app is in background and during day is opened several times
            /// It seems old entries are removed and are not able to get them even though it should be visible based on the
            /// specified position ,
            ///
            /// What is the limit for logs untill it is removed from memory ?
            entries = try store
                .getEntries(at: position)
                .compactMap { $0 as? OSLogEntryLog }
                .filter { $0.subsystem == Bundle.main.bundleIdentifier! }
            state = .ready
        } catch {
            Self.logger.warning("\(error.localizedDescription, privacy: .public)")
            state = .ready
        }
    }
}

extension LogStore {
    ///  Enum type of state of OSLogStore
    enum State {
        case ready
        case loading
    }
}
