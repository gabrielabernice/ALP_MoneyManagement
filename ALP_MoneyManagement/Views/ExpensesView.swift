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
        VStack {
            // displaying the piechart to show the chart for expenses from each inputs
            PieChartView(data:expensesData, title: "Expenses")
                .frame(height: 300)
                .padding(.vertical, 20)
            
            Text("Expenses History")
                .font(.system(size: 25))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,30)
                .padding(.top)
                .padding(.bottom, -1)
            
            // to make a list for the data of expenses that have been saved by the user
            List {
                Section() {
                    // loop the data of expenses that has been saved by the user
                    ForEach(viewModel.expensesHistory) { history in
                        // allow the user to see the detail of the expenses data
                        NavigationLink(destination: EditHistoryView(history: $viewModel.expensesHistory[getIndex(for: history, in: viewModel.expensesHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    // allow the user to delete the data of expenses that has been saved
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
            
            // button that will navigate the user to the inputexpenses view
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
        }
        .navigationTitle("Expenses")
        // to call the functions when the view screen shows up
        .onAppear {
            viewModel.loadExpensesData()
            viewModel.loadExpensesHistory()
        }
    }
    
    // function to delete the expenses history
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Expenses" {
            viewModel.expensesHistory.remove(atOffsets: offsets)
        }
        // update the changes of the history data for expenses after a data is being deleted
        viewModel.saveExpensesHistory()
    }
    
    // function to get the index of the history
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
}

// to edit the history
struct EditExpensesHistoryView: View {
    @Binding var history: History
    
    var body: some View {
        VStack {
            Text("Name: \(history.name)")
            Text("Amount: \(history.amount)")
            Text("Date: \(history.date, formatter: dateFormatter)")
        }
    }
}

// to show the detailed history data of expenses
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



struct AllExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        AllExpensesView()
    }
}
