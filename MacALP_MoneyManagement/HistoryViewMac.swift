//
//  HistoryViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 03/06/23.
//


import SwiftUI
import Charts

struct HistoryViewMac: View {
    @Environment(\.dismiss) var dismiss
    
    // Create an instance of the HistoryViewModel as a state object
    @StateObject private var viewModel = HistoryViewModel()
    
    // State property to control the visibility of the alert
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Chart {
                // to loop the datas of incomes that has been saved by the user
                ForEach(viewModel.incomeHistory) { income in
                    // making the barchart for income
                    BarMark(
                        x: .value("Income", "Income"),
                        y: .value("Income", income.amount)
                    )
                }
                
                // to loop the datas of incomes that has been saved by the user
                ForEach(viewModel.expensesHistory) { expenses in
                    // making the barchart for income
                    BarMark(
                        x: .value("Expenses", "Expenses"),
                        y: .value("Expenses", expenses.amount)
                    )
                }
            }
            .frame(height: 200)
            
            // making the list for the datas from income and expenses that has been saved by the user
            List {
                Section(header: Text("Income")) {
                    // to loop the datas of incomes that has been saved by the user
                    ForEach(viewModel.incomeHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $viewModel.incomeHistory[viewModel.getIndex(for: history, in: viewModel.incomeHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    // to delete the income data
                    .onDelete { offsets in
                        viewModel.deleteHistory(at: offsets, type: "Income")
                        showAlert = true // Show the alert after deletion
                    }
                }
                
                // to loop the datas of expenses that has been saved by the user
                Section(header: Text("Expenses")) {
                    ForEach(viewModel.expensesHistory) { history in
                        NavigationLink(destination: EditHistoryView(history: $viewModel.expensesHistory[viewModel.getIndex(for: history, in: viewModel.expensesHistory)])) {
                            HistoryRow(history: history)
                        }
                    }
                    // to delete the expenses data
                    .onDelete { offsets in
                        viewModel.deleteHistory(at: offsets, type: "Expenses")
                    }
                }
            }
            // displays the content of each row within a visually distinct inset area
            .listStyle(SidebarListStyle())
            
            Button(action: {
                dismiss()
            }) {
                Text("Close")
            }
            .padding()
        }
        // Setting the spacing of the history view frame
        .frame(minWidth: 500, idealWidth: 600, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
        .navigationTitle("History")
        // to call the functions when the view screen shows up
        .onAppear {
            //  Loading data from UserDefaults in the viewModel
            viewModel.loadDataFromUserDefaults()
        }
        // Show an alert when showAlert is true
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Data Deleted"),
                message: Text("The data entry has been successfully deleted."),
                dismissButton: .default(Text("OK"))
            )
        }
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

struct HistoryViewMac_Previews: PreviewProvider {
    static var previews: some View {
        HistoryViewMac()
    }
}
