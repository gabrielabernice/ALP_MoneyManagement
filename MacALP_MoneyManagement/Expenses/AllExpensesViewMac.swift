//
//  AllExpensesViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 01/06/23.
//


import SwiftUI
import SwiftUICharts

struct AllExpensesViewMac: View {
    @StateObject private var viewModel = InputExpensesViewModel()
    @State private var isShowingInputExpensesSheet = false
    
    //It represents the mode in which a view is presented
    @Environment(\.presentationMode) private var presentationMode

    var expensesData: [Double] {
        // It maps each expense history item in viewModel.expensesHistory to its amount as a Double.
        return viewModel.expensesHistory.map { Double($0.amount) }
    }
    
    
    var body: some View {
        VStack {
            // Add a back button
            HStack {
                Button(action: {
                    //accesses the wrapped value of the presentationMode environment property
                    presentationMode.wrappedValue.dismiss()
                }) {
                    //Button Content
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                .padding(.bottom, -20)
                // Add top padding to align with the top of the view
                Spacer()
            }
            
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
                        NavigationLink(destination: EditExpensesHistoryView(history: $viewModel.expensesHistory[getIndex(for: history, in: viewModel.expensesHistory)])) {
                            HistoryExpensesRow(history: history)
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
            
            Button(action: {
                isShowingInputExpensesSheet = true // Set state untuk menampilkan InputIncomeMac
            }) {
                Text("Add New Expenses")
                    .font(.title)
                    .padding(10)
                    .padding(.horizontal, 55)
                    .background(Color(hex:0xF89385))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.bottom, 25)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Set the view's frame to fill the available space
        .navigationTitle("Expenses")
        .sheet(isPresented: $isShowingInputExpensesSheet) {
            InputExpensesMac(isPresented: $isShowingInputExpensesSheet) // Tampilkan InputIncomeMac ketika state isShowingInputIncome bernilai true
                .onDisappear {
                    // to reload data when the sheet disapear
                    viewModel.loadExpensesData()
                    viewModel.loadExpensesHistory()
                }
        }
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
    // It represents the mode in which a view is presented
        @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        //accesses the wrapped value of the presentationMode environment property
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        //Button Content
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .padding(.bottom, -20)
                    
                    Spacer()
                }
                //Detail output text that wanted to show
                Text("Name: \(history.name)")
                Text("Amount: \(history.amount)")
                Text("Date: \(history.date, formatter: dateFormatter)")
            }
        // Add top padding to align with the top of the view
            .padding(.top, 20)
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
    // Make the format output date
    formatter.dateFormat = "MMMM d, yyyy"
    return formatter
}()



struct AllExpensesViewMac_Previews: PreviewProvider {
    static var previews: some View {
        AllExpensesViewMac()
    }
}
