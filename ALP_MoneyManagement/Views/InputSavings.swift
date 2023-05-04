//
//  InputSavings.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct InputSavings: View {
    @State var amount: String = ""
    @State var days: String = ""
    
    @State var checkAmount: Bool = false
    @State var checkDays: Bool = false
    
    @State var perDay = 0
    
    var body: some View {
        VStack{
            Text("Savings Target : ")
                .font(.title2)
            
            HStack{
                Text("Rp. ")
                    .font(.title2)
                
                TextField("ex : 50000", text: $amount)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.system(size: 16, weight: .bold))
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.3), lineWidth: 2)
                    )
                    .keyboardType(.numberPad)
            }
            
            if !checkAmount{
                Text("Please enter a valid amount\n(only numbers above 0)")
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            HStack{
                Text("In")
                    .font(.title2)
                
                TextField("ex : 30", text: $days)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .font(.system(size: 16, weight: .bold))
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.3), lineWidth: 2)
                    )
                    .keyboardType(.numberPad)
                    .frame(width: 100)
                
                Text("days")
                    .font(.title2)
            }
            
            if !checkDays{
                Text("Please enter a valid amount\n(only numbers above 0)")
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Button("Calculate") {
                let amountInt = Int(amount) ?? 0
                let daysInt = Int(days) ?? 0
                perDay = amountInt / daysInt
            }
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(Color(red: 0.4, green: 0.6, blue: 1.0))
            .cornerRadius(10)
            .disabled(!checkAmount || !checkDays)
            
            if perDay > 0 {
                Text("You need to save \nRp. \(perDay) per day")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        .onChange(of: amount) { newValue in
            checkAmount = ((Int(newValue) ?? 0) >= 1)
        }
        .onChange(of: days) { newValue in
            checkDays = ((Int(newValue) ?? 0) >= 1)
        }
        .bold()
        .padding(.horizontal, 30)
    }
}

struct InputSavings_Previews: PreviewProvider {
    static var previews: some View {
        InputSavings()
    }
}