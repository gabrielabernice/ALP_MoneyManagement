//
//  TransactionView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct TransactionView: View {
    @State private var historyView = false
    
    var body: some View {
        NavigationView {
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
                                        NavigationLink(destination: AllIncomeView()) {
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
                                    NavigationLink(destination: AllExpensesView()) {
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Transaction")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
                
                // tool bar to navigate the user to the history view
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        historyView = true
                    }) {
                        Image(systemName: "clock.arrow.circlepath")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $historyView) {
                HistoryView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Set navigation view style to remove sidebar on iPad
    }
}

// to make a customable color for the background of each section
extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
