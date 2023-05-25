//
//  HomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct HomeView: View {
    @State var incomeHistory: [History] = []
    @State var expensesHistory: [History] = []
    
    var totalIncomeAmount: Int {
        incomeHistory.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpensesAmount: Int {
        expensesHistory.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack(alignment: .top, spacing: -20){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                        .padding()
                        .overlay(
                            VStack(alignment: .leading){
                                Text("Income")
                                    .padding(.bottom, 1)
                                Text("Rp \(totalIncomeAmount)")
                                
                            }
                                .padding(.leading, -50)
                            
                        )
                        .frame(width: 208, height: 100)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                        .padding()
                        .overlay(
                            VStack(alignment: .leading){
                                Text("Expenses")
                                    .padding(.bottom, 1)
                                Text("Rp \(totalExpensesAmount)")
                                
                            }
                                .padding(.leading, -50)
                        )
                        .frame(width: 208, height: 100)
                }
                
               TransactionRow()
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadDataFromUserDefaults()
        }
    }
    
    func loadDataFromUserDefaults() {
        if let incomeData = UserDefaults.standard.data(forKey: "incomeHistory") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([History].self, from: incomeData) {
                incomeHistory = decodedData
            }
        }
        
        if let expensesData = UserDefaults.standard.data(forKey: "expensesHistory") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([History].self, from: expensesData) {
                expensesHistory = decodedData
            }
        }
    }
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
