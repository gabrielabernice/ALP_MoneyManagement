//
//  TransactionRow.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct TransactionRow: View {
//    @State private var showLeftArrow = false
//    @State private var showRightArrow = true
//    @State private var contentOffset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Articles")
                .font(.title2)
                .padding(.leading, 18)
                .padding(.top, 10)
                .padding(.bottom, -10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(alignment: .top, spacing: 0) {
                        VStack(spacing: 20) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                                    .padding()
                                    .overlay(
                                        HStack(spacing:-38){
                                            Image("MoneyManagement")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 200, height: 200)
                            
                                            
                                            VStack(spacing:5){
                                                Text("Mastering Budget Management")
                                                    .multilineTextAlignment(.center)
                                                    .font(.system(size: 22))
                                                    .padding(.trailing)
                                                    .bold()
                                                
                                            
                                                NavigationLink(destination: Article1()) {
                                                    Text("Read")
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
                            .padding(.horizontal,-12)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                                .padding()
                                .overlay(
                                    HStack(spacing:-20){
                                        Image("MoneySavings")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 180, height: 200)
                        
                                        
                                        VStack(spacing:5){
                                            Text("The Art of Savings Money")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 22))
                                                .padding(.trailing)
                                                .bold()
                                            
                                        
                                            NavigationLink(destination: Article2()) {
                                                Text("Read")
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
                    .padding(.horizontal)

                    }
                }
            }
            .frame(height: 185)
        }
    }
    


struct Article1: View {
    
    var body: some View {

        VStack {
            Text("Money")
                .font(.title)
            Text("Drop some money")
           
        }
    }
}

struct Article2: View {
    
    var body: some View {

        VStack {
            Text("Money 2")
                .font(.title)
            Text("Drop some money")
           
        }
    }
}



struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow()
    }
}
