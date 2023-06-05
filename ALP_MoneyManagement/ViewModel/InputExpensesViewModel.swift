//
//  InputExpensesViewModel.swift
//  ALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 27/05/23.
//

import Foundation
import SwiftUI
import Dispatch

class InputExpensesViewModel: ObservableObject {
    @Published var expenses: [Expenses] = []
    @Published var selectedOption: Expenses?
    
    @Published var amount: String = ""
    @Published var check: Bool = false
    
    @Published var date = Date()
    @Published var isExpanded = false
    
    @Published var expensesHistory: [History] = []
    @Published var appendExpenses = false
    
    @Published var index = 0
    @Published var type = "Expenses"
    
    @Published var name : String = ""
    
    @Published var showFailMessage = false
    @Published var shouldNavigate = false
    @Published var showInvalidDateMessage = false
    
    // to initialize the expenses data and expenses history data
    
    init() {
        loadExpensesData()
        loadExpensesHistory()
    }
    
    // function to load the data of expenses from the json data
    func loadExpensesData() {
        let url = Bundle.main.url(forResource: "expensesData", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.expenses = try! decoder.decode([Expenses].self, from: jsonData)
    }
    
    // function to load the data from the expenses history
    func loadExpensesHistory() {
        if let data = UserDefaults.standard.data(forKey: "expensesHistory") {
            if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                self.expensesHistory = decodedData
                self.index = expensesHistory.count
            }
        }
    }
    
    // function to save the expenses history
    func saveExpensesHistory() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedData, forKey: "expensesHistory")
        }
    }
    
    // function to get the index of the history
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
    
    // function to delete the expenses history
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Expenses" {
            expensesHistory.remove(atOffsets: offsets)
        }
        // update the changes of the history data for expenses after a data is being deleted
        saveExpensesHistory()
    }
    
    // function to check if the amount is valid (if the amount being inputted is greater than 0)
    func validateAmount() {
        self.check = ((Int(amount) ?? 0) >= 1)
    }
    
    // function to save the expenses
    func saveExpenses() {
        // if the expenses category is not selected, then it will show an error message and the data will not be saved
        if selectedOption == nil {
            showFailMessage = true
            appendExpenses = false
        } else {
            // if the expenses category is selected, then it will not show an error message and the data will be saved
            if check {
                withAnimation(.easeInOut) {
                    expensesHistory.append(History(id: index, category: selectedOption?.expensesCategory ?? "", amount: Int(amount) ?? 0, date: date, type: type, name: name))
                    saveExpensesHistory()
                    appendExpenses = true
                    showFailMessage = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.shouldNavigate = true
                    }
                    index += 1
                }
            }
        }
    }
}
