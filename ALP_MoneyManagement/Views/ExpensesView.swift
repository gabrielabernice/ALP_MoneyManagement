//
//  ExpensesView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct AllExpensesView: View {
    @State var expensesHistory: [History] = []
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Expenses History")
                    .font(.system(size: 25))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,30)
                    .padding(.top)
                    .padding(.bottom, -1)
                
                List {
                    Section() {
                        ForEach(expensesHistory) { history in
                            NavigationLink(destination: EditHistoryView(history: $expensesHistory[getIndex(for: history, in: expensesHistory)])) {
                                HistoryRow(history: history)
                            }
                        }
                        .onDelete { offsets in
                            deleteHistory(at: offsets, type: "Expenses")
                        }
                    }
                    .padding(.top, -15)
                    .padding(.bottom, -15)
                    .padding(.horizontal, -3)
                    
                }
                .listStyle(.inset)
                
                NavigationLink(destination: InputExpenses()) {
                    Text("Add New Expenses")
                        .font(.title)
                        .padding(10)
                        .padding(.horizontal, 45)
                        .background(Color(hex: 0xF89385))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
                
            }
        }
        .navigationTitle("Expenses")
        .onAppear {
            loadDataFromUserDefaults()
        }
    }
    
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Expenses" {
            expensesHistory.remove(atOffsets: offsets)
        }
        
        saveDataToUserDefaults()
    }
    
    func saveDataToUserDefaults() {
        let encoder = JSONEncoder()
        
        if let encodedExpensesData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedExpensesData, forKey: "expensesHistory")
        }
    }
    
    func loadDataFromUserDefaults() {
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

struct EditExpensesHistoryView: View {
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

struct HistoryExpensesRow: View {
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



struct AllExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        AllExpensesView(expensesHistory: [
            History(id: 1, name: "Expenses 1", amount: 50000, date: Date(), type: "Exnpenses"),
            History(id: 2, name: "Expenses 2", amount: 75000, date: Date(), type: "Expenses")
        ])
    }
}
