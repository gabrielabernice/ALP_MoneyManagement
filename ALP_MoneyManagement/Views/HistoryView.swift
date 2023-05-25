//
//  HistoryView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct HistoryView: View {
    @State var incomeHistory: [History] = []
    @State var expensesHistory: [History] = []

    var body: some View {
        VStack {
            List {
                Section(header: Text("Income")) {
                    ForEach(incomeHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $incomeHistory[getIndex(for: history, in: incomeHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Income")
                    }
                }
                
                Section(header: Text("Expenses")) {
                    ForEach(expensesHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $expensesHistory[getIndex(for: history, in: expensesHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Expenses")
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationTitle("History")
        .onAppear {
            loadDataFromUserDefaults()
        }
    }
    
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Income" {
            incomeHistory.remove(atOffsets: offsets)
        } else if type == "Expenses" {
            expensesHistory.remove(atOffsets: offsets)
        }
        
        saveDataToUserDefaults()
    }
    
    func saveDataToUserDefaults() {
        let encoder = JSONEncoder()
        
        if let encodedIncomeData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedIncomeData, forKey: "incomeHistory")
        }
        
        if let encodedExpensesData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedExpensesData, forKey: "expensesHistory")
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
    
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
}

struct EditHistoryView: View {
    @Binding var history: History
    
    var body: some View {
        // Tampilan untuk mengedit entri History
        VStack {
            Text("Name: \(history.name)")
            Text("Amount: \(history.amount)")
            Text("Date: \(history.date, formatter: dateFormatter)")
            // Tambahkan informasi lain yang ingin diubah
        }
    }
}

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
            // Tambahkan informasi lain yang ingin ditampilkan
        }
        .padding()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(incomeHistory: [
            History(id: 1, name: "Income 1", amount: 50000, date: Date(), type: "Income"),
            History(id: 2, name: "Income 2", amount: 75000, date: Date(), type: "Income")
        ])
    }
}
