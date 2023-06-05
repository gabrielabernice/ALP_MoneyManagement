//
//  MainViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 03/06/23.
//

import SwiftUI
struct MainViewMac: View {
    @State private var isSidebarVisible = true
    @State private var isDarkModeOn = false
    @State var selection: NavigationItem = .home
        
        enum NavigationItem {
            case home
            case transaction
            case savings
        }
    
    var body: some View {
        NavigationSplitView {
                    List(selection: $selection) {
                        NavigationLink(value: NavigationItem.home) {
                            Label("Home", systemImage: "house.fill")
                        }
                        NavigationLink(value: NavigationItem.transaction) {
                            Label("Transaction", systemImage: "dollarsign.circle.fill")
                        }
                        NavigationLink(value: NavigationItem.savings) {
                            Label("Savings", systemImage: "creditcard.fill")
                        }
                    }
                    .frame(minWidth: 200)
                } detail: {
                    switch selection {
                    case .home:
                        HomeViewMac()
                    case .transaction:
                        TransactionViewMac()
                    case .savings:
                        InputSavingsMac()
                    }
                }
                .preferredColorScheme(isDarkModeOn ? .dark : .light)

    }
}


struct MainViewMac_Previews: PreviewProvider {
    static var previews: some View {
        MainViewMac()
    }
}
