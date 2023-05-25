//
//  TransactionView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                            .padding()
                            .overlay(
                                HStack (spacing:-14){
                                    // Gambar
                                    Image("incomeLogo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 170, height: 200)
                                    
                                    // Tombol dengan NavigationLink
                                    VStack(spacing:5){
                                        Text("In this menu you can input your Income")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                        
                                        NavigationLink(destination: AllIncomeView()) {
                                            Text("Income")
                                                .font(.title)
                                                .padding()
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
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: 0xF0A79D).opacity(0.3))
                        .padding()
                        .overlay(
                            HStack (spacing:-14){
                                // Gambar
                                Image("ExpensesLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 155, height: 200)
                                
                                // Tombol dengan NavigationLink
                                VStack(spacing:5){
                                    Text("In this menu you can input your Expenses")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 20))
                                        .padding(.trailing)
                                    
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
            }
            
            
        }
        
        
    }
}


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
