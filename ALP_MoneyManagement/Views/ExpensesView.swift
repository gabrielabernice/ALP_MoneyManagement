//
//  ExpensesView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI
import SwiftUICharts

struct AllExpensesView: View {
    @StateObject private var viewModel = InputExpensesViewModel()
    
    var expensesData: [Double] {
        return viewModel.expensesHistory.map { Double($0.amount) }
    }
    
    var body: some View {
        //        NavigationView{
        VStack {
            PieChartView(data:expensesData, title: "Expenses")
                .frame(height: 300)
                .padding(.vertical, 20)
            
            Text("Expenses History")
                .font(.system(size: 25))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,30)
                .padding(.top)
                .padding(.bottom, -1)
            
            List {
                Section() {
                    ForEach(viewModel.expensesHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $viewModel.expensesHistory[getIndex(for: history, in: viewModel.expensesHistory)])) {
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
            Spacer()
            NavigationLink(destination: InputExpenses()) {
                Text("Add New Expenses")
                    .font(.title)
                    .padding(10)
                    .padding(.horizontal, 45)
                    .background(Color(hex: 0xF89385))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
            .padding(.bottom, 65)
            //            }
        }
        .navigationTitle("Expenses")
        .onAppear {
            viewModel.loadExpensesData()
            viewModel.loadExpensesHistory()
        }
    }
    
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Expenses" {
            viewModel.expensesHistory.remove(atOffsets: offsets)
        }
        viewModel.saveExpensesHistory() // Menyimpan perubahan riwayat pendapatan setelah penghapusan
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
        AllExpensesView()
    }
}
