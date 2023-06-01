//
//  MainViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 01/06/23.
//

import SwiftUI
struct MainViewMac: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isSidebarExpanded = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isSidebarExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isSidebarExpanded ? "sidebar.left" : "sidebar.right")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    
                    Spacer()
                }

                List {
                    Text("Menu")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.top, 12)
                        .padding(.bottom, 10)

                    NavigationLink(destination: HomeViewMac()) {
                        HStack(alignment: .center) {
                            Image(systemName: "house.fill")
                                .frame(width: 24)
                            Text("Home")
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.vertical, 1)
                    .padding(.leading, 20)

                    NavigationLink(destination: TransactionViewMac()) {
                        HStack(alignment: .center) {
                            Image(systemName: "list.bullet.clipboard")
                                .frame(width: 24)
                            Text("Transaction")
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.vertical, 1)
                    .padding(.leading, 20)

                    NavigationLink(destination: InputSavings()) {
                        HStack(alignment: .center) {
                            Image(systemName: "creditcard.fill")
                                .frame(width: 24)
                            Text("Savings")
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.vertical, 1)
                    .padding(.leading, 20)
                }
                .listStyle(SidebarListStyle())
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            }

            HomeViewMac()
        }
    }
}



struct MainViewMac_Previews: PreviewProvider {
    static var previews: some View {
        MainViewMac()
    }
}
