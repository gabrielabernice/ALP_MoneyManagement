//
//  HistoryView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI
import Charts


struct HistoryView: View {
    @State var incomeHistory: [History] = []
    @State var expensesHistory: [History] = []

    var body: some View {
        VStack {
            Chart {
                // to loop the datas of incomes that has been saved by the user
                    ForEach(incomeHistory) { income in
                        // making the barchart for income
                            BarMark(
                                x: .value("Income", "Income"),
                                y: .value("Income", income.amount)
                                    )
                                }
                
                // to loop the datas of incomes that has been saved by the user
                    ForEach(expensesHistory) { expenses in
                        // making the barchart for income
                            BarMark(
                                x: .value("Expenses", "Expenses"),
                                y: .value("Expenses", expenses.amount)
                                    )
                                    }
                                }
            
            // making the list for the datas from income and expenses that has been saved by the user
            List {
                Section(header: Text("Income")) {
                    // to loop the datas of incomes that has been saved by the user
                    ForEach(incomeHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $incomeHistory[getIndex(for: history, in: incomeHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    // to delete the income data
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Income")
                    }
                }
                
                // to loop the datas of expenses that has been saved by the user
                Section(header: Text("Expenses")) {
                    ForEach(expensesHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $expensesHistory[getIndex(for: history, in: expensesHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    // to delete the expenses data
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Expenses")
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationTitle("History")
        // to call the functions when the view screen shows up
        .onAppear {
            loadDataFromUserDefaults()
        }
    }
    
    // function to delete the history of income and expenses
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Income" {
            incomeHistory.remove(atOffsets: offsets)
        } else if type == "Expenses" {
            expensesHistory.remove(atOffsets: offsets)
        }
        
        saveDataToUserDefaults()
    }
    
    // function to save the data to history
    func saveDataToUserDefaults() {
        let encoder = JSONEncoder()
        
        if let encodedIncomeData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedIncomeData, forKey: "incomeHistory")
        }
        
        if let encodedExpensesData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedExpensesData, forKey: "expensesHistory")
        }
    }
    
    // function to load all the data of income and expenses
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
    
    // function to get the index of the history (income and expenses)
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
}

// to edit the history (income and expenses)
struct EditHistoryView: View {
    @Binding var history: History
    
    var body: some View {
        VStack {
            Text("Name: \(history.name)")
            Text("Amount: \(history.amount)")
            Text("Date: \(history.date, formatter: dateFormatter)")
        }
    }
}

// to show the history detail (income and expenses)
struct HistoryRow: View {
    var history: History
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(history.name)")
                .font(.headline)
            Text("Amount: Rp. \(history.amount)")
                .font(.subheadline)
            Text("Date: \(history.date, formatter: dateFormatter)")
                .font(.subheadline)
        }
        .padding()
    }
}

// to make the format of the date picker, using the long date style, and not recording the time
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(incomeHistory: [
            History(id: 1, category: "Salary", amount: 50000, date: Date(), type: "Income", name: "Income 1"),
            History(id: 2, category: "Investment", amount: 75000, date: Date(), type: "Income", name: "Income 2")
        ])
    }
}
