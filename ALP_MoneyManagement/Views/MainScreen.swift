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
            // tab for the home page
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // tab for the transaction page (for input income and expenses, and also the history)
            TransactionView()
                .tabItem {
                    Label("Transaction", systemImage: "dollarsign.circle.fill")
                }
            
            // tab for savings feature
            SavingsView(savings: savings)
                .tabItem {
                    Label("Savings", systemImage: "creditcard.fill")
                }
        }
        // to hide the "back" navigation
        .navigationBarBackButtonHidden(true)
    }
}

// to display the inputsavings view
struct SavingsView: View {
    var savings: String
    
    var body: some View {
        InputSavings()
    }
}

// to display the history view
struct IncomeExpensesHistoryView: View {
    var history: [History]
    
    var body: some View {
        HistoryView()
    }
}

struct MainScreen_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        MainScreen(savings: "S", history: [History(id: 0, category: "Shopping", amount: 30000, date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 7)) ?? Date(), type: "Expenses", name: "Makan")])
            .environmentObject(modelData)
    }
}
