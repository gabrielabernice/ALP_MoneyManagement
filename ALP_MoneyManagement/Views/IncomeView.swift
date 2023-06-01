//
//  IncomeView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI
import SwiftUICharts

struct AllIncomeView: View {
    // Create an instance of the InputIncomeViewModel as a state object
    @StateObject private var viewModel = InputIncomeViewModel()
    
    // State property to control the visibility of the alert
    @State private var showAlert = false
    
    var incomeData: [Double] {
        return viewModel.incomeHistory.map { Double($0.amount) }
    }
    
    var body: some View {
        VStack {
            // displaying the piechart to show the chart for income from each inputs
            PieChartView(data:incomeData, title: "Income",style: Styles.barChartStyleNeonBlueLight, form: ChartForm.large).padding(.horizontal)
                .frame(height: 300)
                .padding(.vertical, 20)
            
            
            Text("Income History")
                .font(.system(size: 25))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,30)
                .padding(.top)
                .padding(.bottom, -1)
            
            // to make a list for the data of incomes that have been saved by the user
            List {
                Section() {
                    // loop the data of income that has been saved by the user
                    ForEach(viewModel.incomeHistory) { history in
                        // allow the user to see the detail of the income data
                        NavigationLink(destination: EditIncomeHistoryView(history: $viewModel.incomeHistory[viewModel.getIndex(for: history, in: viewModel.incomeHistory)])) {
                            HistoryIncomeRow(history: history)
                        }
                    }
                    // allow the user to delete the data of income that has been saved
                    .onDelete { offsets in
                        viewModel.deleteHistory(at: offsets, type: "Income")
                        // Show the alert after deletion
                        showAlert = true
                    }
                }
                .padding(.top, -15)
                .padding(.bottom, -15)
                .padding(.horizontal, -3)
            }
            .listStyle(.inset)
            
            Spacer()
            
            // button that will navigate the user to the inputincome view
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
        .navigationTitle("Income")
        // to call the functions when the view screen shows up
        .onAppear {
            viewModel.loadIncomeData()
            viewModel.loadIncomeHistory()
        }
        .alert(isPresented: $showAlert) {
            // Show an alert when showAlert is true
            Alert(
                title: Text("Data Deleted"),
                message: Text("The data entry has been successfully deleted."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// to edit the history
struct EditIncomeHistoryView: View {
    @Binding var history: History

    var body: some View {
        VStack {
            Text("Name: \(history.name)")
            Text("Amount: \(history.amount)")
            Text("Date: \(history.date, formatter: dateFormatter)")
        }
    }
}

// to show the detailed history data of income
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


struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        AllIncomeView()
    }
}
