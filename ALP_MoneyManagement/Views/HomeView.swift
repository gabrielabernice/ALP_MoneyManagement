//
//  HomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    @StateObject var incomeViewModel = InputIncomeViewModel()
    @StateObject var expensesViewModel = InputExpensesViewModel()
    
    var totalIncomeAmount: Int {
        incomeViewModel.incomeHistory.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpensesAmount: Int {
        expensesViewModel.expensesHistory.reduce(0) { $0 + $1.amount }
    }
    
    var incomeData: [Double] {
        return incomeViewModel.incomeHistory.map { Double($0.amount) }
    }

    var expensesData: [Double] {
        return expensesViewModel.expensesHistory.map { Double($0.amount) }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if incomeViewModel.incomeHistory.isEmpty && expensesViewModel.expensesHistory.isEmpty {
                        Text("No data available")
                            .foregroundColor(.gray)
                            .font(.title)
                            .padding()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                if !incomeViewModel.incomeHistory.isEmpty {
                                    LineChartView(data: incomeData,
                                                  title: "Income Chart",
                                                  legend: "Income")
                                    .frame(height: 240)
                                    .padding()
                                }
                                
                                if !expensesViewModel.expensesHistory.isEmpty {
                                    LineChartView(data:  expensesData,
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
                incomeViewModel.loadIncomeHistory()
                expensesViewModel.loadExpensesHistory()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
