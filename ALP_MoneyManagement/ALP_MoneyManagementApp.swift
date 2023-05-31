//
//  ALP_MoneyManagementApp.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI

#if os(macOS)
@main
struct ALP_MoneyManagementApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        Settings {
            SettingsView()
        }
    }
}
#else
@main
struct ALP_MoneyManagementApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
#endif
