//
//  MainViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 01/06/23.
//

import SwiftUI


struct MainViewMac: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            List {
                Text("Menu")
//                    .customFont(.largeTitle2)
//                    .foregroundColor(.white)
                    .padding(.top, 12)
                NavigationLink(destination: HomeViewMac()) {
                    HStack(alignment: .center) {
                        VStack {
                            Image(systemName: "home")
//                                .customFont(.subheadline)
                        }
                        .frame(width: 24)
                        Text("Home")
//                            .customFont(.subheadline)
//                            .padding(.top, 4)
                    }
                    .foregroundColor(.white)
                }
                .padding(.vertical, 1)
                .padding(.leading, 20)
                NavigationLink(destination: TransactionViewMac()) {
                    HStack(alignment: .center) {
                        VStack {
                            Image(systemName: "list.bullet.clipboard")
//                                .customFont(.subheadline)
                        }
                        .frame(width: 24)
                        Text("Transaction")
//                            .customFont(.subheadline)
//                            .padding(.top, 4)
                    }
                    .foregroundColor(.white)
                }
                .padding(.vertical, 1)
                .padding(.leading, 20)
//                NavigationLink(destination: S) {
//                    HStack(alignment: .center) {
//                        VStack {
//                            Image(systemName: "person")
//                                .customFont(.subheadline)
//                        }
//                        .frame(width: 24)
//                        Text("Profile")
//                            .customFont(.subheadline)
//                            .padding(.top, 4)
//                    }
//                    .foregroundColor(.white)
//                }
//                .padding(.vertical, 1)
//                .padding(.leading, 20)
            }
//            .background(Color(hex: "EF233C"))
            
            HomeViewMac()
        }
    }
}

struct MainViewMac_Previews: PreviewProvider {
    static var previews: some View {
        MainViewMac()
    }
}
