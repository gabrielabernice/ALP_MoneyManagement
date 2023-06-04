//
//  HomeViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 30/05/23.
//

import SwiftUI
import SwiftUICharts


struct HomeViewMac: View {
    @StateObject var incomeViewModel = InputIncomeViewModel()
    @StateObject var expensesViewModel = InputExpensesViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    // to get the total income amount from the data that has been saved
    var totalIncomeAmount: Int {
        incomeViewModel.incomeHistory.reduce(0) { $0 + $1.amount }
    }
    
    // to get the total expenses amount from the data that has been saved
    var totalExpensesAmount: Int {
        expensesViewModel.expensesHistory.reduce(0) { $0 + $1.amount }
    }
    //computed properties convert the amount values of the History objects into the Double type
    var incomeData: [Double] {
        return incomeViewModel.incomeHistory.map { Double($0.amount) }
    }
    var expensesData: [Double] {
        return expensesViewModel.expensesHistory.map { Double($0.amount) }
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                // to check if there are no data (income and expenses) has been inputed, the chart will not be shown, and the text will be shown
                if incomeViewModel.incomeHistory.isEmpty && expensesViewModel.expensesHistory.isEmpty {
                    Text("No data available")
                        .foregroundColor(.gray)
                        .font(.title)
                        .padding()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            // to check if there are data (income and expenses) has been inputed, the chart will be shown
                            if !incomeViewModel.incomeHistory.isEmpty &&  !expensesViewModel.expensesHistory.isEmpty {
                                MultiLineChartView(data: [(incomeData, GradientColors.blue), (expensesData, GradientColors.orange)], title: "Data", style: Styles.lineChartStyleOne, form: ChartForm.extraLarge).padding(.horizontal)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                //                                    .background(colorScheme == .dark ? Color.black : Color.white)
                                    .frame(height: 240)
                                    .padding()
                            }
                            VStack{
                                // income section
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                                    .padding(.leading, 10)
                                    .padding()
                                    .overlay(
                                        // income data
                                        VStack(alignment: .leading) {
                                            Text("Income")
                                                .padding(.bottom, 1)
                                                .bold()
                                            Text("Rp \(totalIncomeAmount)")
                                        }
                                            .padding(.leading, -120)
                                    )
                                    .frame(width: 320, height: 100)
                                
                                // expenses section
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(hex: 0xF89385).opacity(0.3))
                                    .padding(.leading, 10)
                                    .padding()
                                    .overlay(
                                        // income data
                                        VStack(alignment: .leading) {
                                            Text("Expenses")
                                                .padding(.bottom, 1)
                                                .bold()
                                            Text("Rp \(totalExpensesAmount)")
                                        }
                                            .padding(.leading, -120)
                                    )
                                    .frame(width: 320, height: 100)
                                
                            }
                        }
                    }
                }
                
                // to show the total amount of income and expenses that has been saved by the user
                HStack(alignment: .top, spacing: -15) {
                    
                }
                .padding(.vertical, 30)
                
                // for the articles section
                ArticleViewMac()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            incomeViewModel.loadIncomeHistory()
            expensesViewModel.loadExpensesHistory()
        }
    }
}
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}


struct HomeViewMac_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMac()
            .frame(width: 800)
    }
}
