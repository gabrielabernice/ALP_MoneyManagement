//
//  MainScreen.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var modelData: ModelData
    var income: [Income]{
        modelData.income
    }
    
    var expenses: [Expenses]{
        modelData.expenses
    }
    
    var savings: String
    
    var history: [History]
    
    var body: some View {
        TabView {
            IncomeView(income: income)
                .tabItem {
                    Label("Income", systemImage: "dollarsign.circle.fill")
                }
            
            ExpensesView(expenses: expenses)
                .tabItem {
                    Label("Expenses", systemImage: "cart")
                }
            
            SavingsView(savings: savings)
                .tabItem {
                    Label("Savings", systemImage: "creditcard.fill")
                }
            
            IncomeExpensesHistoryView(history: history)
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
        
    }
}

struct IncomeView: View {
    var income: [Income]
    
    var body: some View {
        NavigationView {
            InputIncome()
        }
    }
}

struct ExpensesView: View {
    var expenses: [Expenses]
    
    var body: some View {
        NavigationView {
            InputExpenses()
        }
    }
}

struct SavingsView: View {
    var savings: String
    
    var body: some View {
        InputSavings()
    }
}

struct IncomeExpensesHistoryView: View {
    var history: [History]
    
    var body: some View {
        HistoryView()
    }
}

struct MainScreen_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        MainScreen(savings: "S", history: [History(id: 0, name: "Shopping", amount: 30000, date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 7)) ?? Date(), type: "Expenses")])
            .environmentObject(modelData)
    }
}
