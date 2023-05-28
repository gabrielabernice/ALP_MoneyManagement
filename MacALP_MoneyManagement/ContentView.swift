//
//  ContentView.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 28/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
