//
//  LogView.swift
//  Approver
//
//  Created by Gadireddi Erik on 05.10.2022.
//  Copyright © 2022 Avast. All rights reserved.
//

import SwiftUI

struct LogView: View {
    @ObservedObject var logStore: LogStore
    var body: some View {
        List {
            switch logStore.state {
            case .ready:
                Section(footer: Text("Debug logs are visible only via debug session or via Console")) {
                    Picker("", selection: $logStore.category) {
                        ForEach(LogsCategory.allCases, id: \.self) { value in
                            Text(value.description)
                                .tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                ForEach(logStore.selectedLogs
                        , id: \.self) { line in
                    Text(line)
                        .listRowInsets(EdgeInsets())
                }.listStyle(.plain)
            case .loading:
                Section {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                
            }
        }.onAppear() {
            logStore.state = .loading
            Task {
                try await logStore.export()
            }
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(logStore: LogStore())
    }
}
