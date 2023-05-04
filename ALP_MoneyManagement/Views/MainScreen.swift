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
    
    var body: some View {
        TabView {
            IncomeView(income: income)
                .tabItem {
                    Label("Income", systemImage: "fork.knife")
                }
            
            ExpensesView(expenses: expenses)
                .tabItem {
                    Label("Expenses", systemImage: "wineglass")
                }
            
            SavingsView(savings: savings)
                .tabItem {
                    Label("Savings", systemImage: "wineglass")
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
            Text("Testing")
                .navigationTitle("Expenses 💸")
        }
    }
}

struct SavingsView: View {
    var savings: String
    
    var body: some View {
        NavigationView {
            Text("Testing")
                .navigationTitle("Savings 💳")
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        MainScreen(savings: "Study Abroad")
            .environmentObject(modelData)
    }
}
