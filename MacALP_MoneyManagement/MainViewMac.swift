//
//  MainViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 03/06/23.
//

import SwiftUI
struct MainViewMac: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeViewMac()) {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
                
                NavigationLink(destination: TransactionViewMac()) {
                    Label("Transaction", systemImage: "list.bullet.clipboard")
                }
                .tag(2)
                
                NavigationLink(destination: InputSavingsMac()) {
                    Label("Savings", systemImage: "creditcard")
                }
                .tag(3)
            }
            .listStyle(SidebarListStyle())
            .padding(.top, 20) // Move the list slightly downward
            
            Text("Select menu from the sidebar")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 800, idealWidth: 1000, minHeight: 600) // Set the initial size of the window
        .navigationTitle("MoneyFest")
    }
}

struct MainViewMac_Previews: PreviewProvider {
    static var previews: some View {
        MainViewMac()
    }
}
