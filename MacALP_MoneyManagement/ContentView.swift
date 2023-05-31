//
//  ContentView.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 28/05/23.
//

import SwiftUI
import SwiftUICharts



struct ContentView: View {
    var body: some View {
        #if os(macOS)
        HomeViewMac()
        #else
        HomeView()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

