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
        NavigationView {
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
                                if !incomeViewModel.incomeHistory.isEmpty && !expensesViewModel.expensesHistory.isEmpty {
                                    
                                    // If the device's user interface idiom is iPad:
                                    if UIDevice.current.userInterfaceIdiom == .pad {
                                        MultiLineChartView(data: [(incomeData, GradientColors.blue), (expensesData, GradientColors.orange)], title: "Income & Expenses", style: Styles.lineChartStyleOne, form: ChartForm.extraLarge)
                                            .offset(x: 200)
                                            .padding(.horizontal)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            .background(colorScheme == .dark ? Color.black : Color.white)
                                            .frame(height: 240, alignment: .center)
                                            .padding()
                                    } else {
                                        MultiLineChartView(data: [(incomeData, GradientColors.blue), (expensesData, GradientColors.orange)], title: "Income & Expenses", style: Styles.lineChartStyleOne, form: ChartForm.large)
                                            .padding(.horizontal)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            .background(colorScheme == .dark ? Color.black : Color.white)
                                            .frame(height: 240, alignment: .center)
                                            .padding()
                                    }
                                    // Additional modifiers can be added here
                                    
                                }
                                
                            }
                            .frame(alignment: .center)
                        }
                    }
                    
                    // to show the total amount of income and expenses that has been saved by the user
                    HStack(alignment: .top, spacing: -15) {
                        
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
                                    Text("Rp \(totalIncomeAmount)")
                                }
                                .padding(.leading, -50)
                            )
                            .frame(width: 220, height: 100)
                        
                        // expenses section
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex: 0xF89385).opacity(0.3))
                            .padding(.trailing, 10)
                            .padding()
                            .overlay(
                                // expenses data
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
                    
                    // for the articles section
                    ArticlesRow()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            // to call the functions when the view screen shows up
            .onAppear {
                incomeViewModel.loadIncomeHistory()
                expensesViewModel.loadExpensesHistory()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Set navigation view style to remove sidebar on iPad
    }
}

// indicating that the current device is an iPad with a sufficiently large screen
struct DeviceTypes {
    static var isPad: Bool {
        //This property checks whether the current device is an iPad
        return UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height >= 2048
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


