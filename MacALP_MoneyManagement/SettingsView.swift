//
//  SettingsView.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 31/05/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isDarkModeOn: Bool
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            
        
            Toggle("Dark Mode", isOn: $isDarkModeOn)
                           .padding()
                       
                       Spacer()
                   }
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isDarkModeOn: .constant(false))
    }
}
