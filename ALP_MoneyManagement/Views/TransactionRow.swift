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
            Text("Transaction")
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
                                        HStack (spacing:-14){
                                            Image("incomeLogo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 170, height: 200)
                                            
                                        
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
                            .padding(.horizontal,-12)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: 0xF0A79D).opacity(0.3))
                                .padding()
                                .overlay(
                                    HStack (spacing:-14){
                                        Image("ExpensesLogo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 155, height: 200)
                                        
                                        
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
                    .padding(.horizontal)
//                    .onChange(of: contentOffset) { newValue in
//                        updateArrowVisibility(newValue)
                    }
//                        .overlay(arrows)
                }
            }
            .frame(height: 185)
        }
//        .navigationBarTitleDisplayMode(.inline)
    }
    
//    var arrows: some View {
//        HStack {
//
//            if showLeftArrow {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(.gray)
//                    .onTapGesture {
//                        scrollToPreviousCard()
//                    }
//                    .padding()
//            }
//
//            Spacer()
//
//            if showRightArrow {
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.gray)
//                    .onTapGesture {
//                        scrollToNextCard()
//                    }
//                    .padding()
//            }
//
//            Spacer()
//        }
//    }
//
//    func updateArrowVisibility(_ offset: CGFloat) {
//        let screenWidth = UIScreen.main.bounds.width
//        let maxContentOffset = screenWidth * CGFloat(2 - 1)
//
//        showLeftArrow = offset > 0
//        showRightArrow = offset < maxContentOffset
//    }
//
//    func scrollToPreviousCard() {
//        withAnimation {
//            contentOffset -= UIScreen.main.bounds.width
//            updateArrowVisibility(contentOffset)
//        }
//    }
//
//    func scrollToNextCard() {
//        withAnimation {
//            contentOffset += UIScreen.main.bounds.width
//            updateArrowVisibility(contentOffset)
//        }
//    }
//
//}






struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow()
    }
}
