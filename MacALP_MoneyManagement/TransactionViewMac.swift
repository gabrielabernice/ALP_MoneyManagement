//
//  TransactionViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 01/06/23.
//

import SwiftUI

struct TransactionViewMac: View {
    @State private var historyView = false
    
    var body: some View {
//        NavigationView{
            VStack{
                
                // making the income section
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                            .padding()
                            .overlay(
                                HStack (spacing:-14){
                                    // image for the income section
                                    Image("incomeLogo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 170, height: 200)
                                    
                                    VStack(spacing:5){
                                        Text("In this menu you can input your Income")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                        
                                        // to navigate the user to the income section view
                                        NavigationLink(destination: AllIncomeViewMac()) {
                                            Text("Income")
                                                .font(.title)
                                                .padding()
                                                .padding(.horizontal)
                                                .background(Color(hex: 0x6DA3FF))
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .padding(.trailing)
                                        }
                                        .padding()
                                    }
                                }
                            )
                    }
                    .frame(width: 380, height: 280)
                }
                
                // making the expenses section
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: 0xF0A79D).opacity(0.3))
                        .padding()
                        .overlay(
                            HStack (spacing:-14){
                                // image for the expenses section
                                Image("ExpensesLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 155, height: 200)
                                
                                VStack(spacing:5){
                                    Text("In this menu you can input your Expenses")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 20))
                                        .padding(.trailing)
                                    
                                    // to navigate the user to the expenses section view
                                    NavigationLink(destination: AllExpensesViewMac()) {
                                        Text("Expenses")
                                            .font(.title)
                                            .padding()
                                            .background(Color(hex: 0xF89385))
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .padding(.trailing)
                                    }
                                    .padding()
                                }
                            }
                        )
                }
                .frame(width: 380, height: 280)
            }
            .padding(.top, -135)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Transaction")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
                
                ToolbarItemGroup(placement: .navigation) {
                    Spacer()
                    Button(action: {
                        historyView = true
                    }) {
                        Image(systemName: "clock.arrow.circlepath")
                            .imageScale(.large)
                    }
                }
            }

            .sheet(isPresented: $historyView, onDismiss: {
                        historyView = false
                    }) {
                        HistoryViewMac()
                    }
//        }
    }
    
}
struct TransactionViewMac_Previews: PreviewProvider {
    static var previews: some View {
        TransactionViewMac()
    }
}
