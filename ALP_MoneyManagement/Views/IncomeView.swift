//
//  IncomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI
import SwiftUICharts

struct AllIncomeView: View {
//    @State var incomeHistory: [History] = []
    @StateObject private var viewModel = InputIncomeViewModel()
    
    var incomeData: [Double] {
        return viewModel.incomeHistory.map { Double($0.amount) }
    }

    var body: some View {
        //        NavigationView{
        VStack {

            PieChartView(data:incomeData, title: "Income",style: Styles.pieChartStyleOne, form: ChartForm.large).padding(.horizontal)
               
                .frame(height: 300)
                .padding(.vertical, 20)
                
            Text("Income History")
                .font(.system(size: 25))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,30)
                .padding(.top)
                .padding(.bottom, -1)
            
            List {
                Section() {
                    ForEach(viewModel.incomeHistory) { history in
                        NavigationLink(destination: EditIncomeHistoryView(history: $viewModel.incomeHistory[getIndex(for: history, in: viewModel.incomeHistory)])) {
                            HistoryIncomeRow(history: history)
                        }
                    }
                    .onDelete { offsets in
                        deleteHistory(at: offsets, type: "Income")
                    }
                }
                .padding(.top, -15)
                .padding(.bottom, -15)
                .padding(.horizontal, -3)
            }
            .listStyle(.inset)
            Spacer()
            NavigationLink(destination: InputIncome()) {
                Text("Add New Income")
                    .font(.title)
                    .padding(10)
                    .padding(.horizontal, 55)
                    .background(Color(hex: 0x6DA3FF))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
            .padding(.bottom, 25)
        }
        
        //            }
        .navigationTitle("Income")
        .onAppear {
            viewModel.loadIncomeData()
            viewModel.loadIncomeHistory()

        }
    }
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Income" {
           viewModel.incomeHistory.remove(atOffsets: offsets)
        }
        viewModel.saveIncomeHistory() // Menyimpan perubahan riwayat pendapatan setelah penghapusan
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
        AllIncomeView()
    }
}
