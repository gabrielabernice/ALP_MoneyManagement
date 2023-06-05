//
//  ALP_MoneyManagementApp.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI


@main
struct ALP_MoneyManagementApp: App {
    @StateObject private var modelData = ModelData()
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
#if os(macOS)
        Settings {
            SettingsView(isDarkModeOn: $isDarkModeOn)
        }
#endif
    }
}
