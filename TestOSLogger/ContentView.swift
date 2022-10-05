//
//  ContentView.swift
//  TestOSLogger
//
//  Created by Gadireddi Erik on 05.10.2022.
//

import SwiftUI
import OSLog

struct ContentView: View {
    // MARK: - Tracking
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ContentView.self)
    )
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Button {
                    Self.logger.info("Log tapped button")
                } label: {
                    Text("Generate log")
                }
                NavigationLink(destination: LogView(logStore: LogStore())) {
                    Text("Show logs")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
