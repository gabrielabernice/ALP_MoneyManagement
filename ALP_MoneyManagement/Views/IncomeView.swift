//
//  IncomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct AllIncomeView: View {
    @State var incomeHistory: [History] = []
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("")) {
                    ForEach(incomeHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $incomeHistory[getIndex(for: history, in: incomeHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Income")
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
        }
        saveDataToUserDefaults()
    }
    
    func saveDataToUserDefaults() {
        let encoder = JSONEncoder()
        
        if let encodedIncomeData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedIncomeData, forKey: "incomeHistory")
        }
    }
    
    func loadDataFromUserDefaults() {
        if let incomeData = UserDefaults.standard.data(forKey: "incomeHistory") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([History].self, from: incomeData) {
                incomeHistory = decodedData
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

struct EditIncomeHistoryView: View {
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

struct HistoryIncomeRow: View {
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


struct IncomeView_Previews: PreviewProvider {
        static var previews: some View {
            AllIncomeView(incomeHistory: [
                History(id: 1, name: "Income 1", amount: 50000, date: Date(), type: "Income"),
                History(id: 2, name: "Income 2", amount: 75000, date: Date(), type: "Income")
            ])
        }
}
