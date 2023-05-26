//
//  HomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    @State var incomeHistory: [History] = []
    @State var expensesHistory: [History] = []
    
    var totalIncomeAmount: Int {
        incomeHistory.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpensesAmount: Int {
        expensesHistory.reduce(0) { $0 + $1.amount }
    }
    
    var incomeData: [Double] {
        return incomeHistory.map { Double($0.amount) }
    }
    
    var expensesData: [Double] {
        return expensesHistory.map { Double($0.amount) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if incomeHistory.isEmpty && expensesHistory.isEmpty {
                        Text("No data available")
                            .foregroundColor(.gray)
                            .font(.title)
                            .padding()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                if !incomeHistory.isEmpty {
                                    LineChartView(data: incomeData,
                                                  title: "Income Chart",
                                                  legend: "Income")
                                    .frame(height: 240)
                                    .padding()
                                }
                                
                                if !expensesHistory.isEmpty {
                                    LineChartView(data: expensesData,
                                                  title: "Expenses Chart",
                                                  legend: "Expenses")
                                    .frame(height: 240)
                                    .padding()
                                }
                            }
                        }
                    }
                    HStack(alignment: .top, spacing: -15) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                            .padding(.leading, 10)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading) {
                                    Text("Income")
                                        .padding(.bottom, 1)
                                    Text("Rp \(totalIncomeAmount)")
                                }
                                    .padding(.leading, -50)
                            )
                            .frame(width: 220, height: 100)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: 0xF89385).opacity(0.3))
                            .padding(.trailing, 10)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading) {
                                    Text("Expenses")
                                        .padding(.bottom, 1)
                                    Text("Rp \(totalExpensesAmount)")
                                }
                                    .padding(.leading, -50)
                            )
                            .frame(width: 220, height: 100)
                    }
                    .padding(.vertical, 60)
                    
                    TransactionRow()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadDataFromUserDefaults()
            }
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
