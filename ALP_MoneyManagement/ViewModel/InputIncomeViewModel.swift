//
//  InputIncomeViewModel.swift
//  ALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 27/05/23.
//

import Foundation
import SwiftUI
import Dispatch

class InputIncomeViewModel: ObservableObject {
    // published which means any changes to this array will notify the subscribe
    @Published var income: [Income] = []
    // object that represents the currently selected option.
    @Published var selectedOption: Income?
    
    // A string representing the amount of income.
    @Published var amount: String = ""
    // A boolean flag used for some check operation.
    @Published var check: Bool = false
    
    @Published var date = Date()
    @Published var isExpanded = false
    
    @Published var incomeHistory: [History] = []
    @Published var appendIncome = false
    
    @Published var index = 0
    @Published var type = "Income"
    
    @Published var name : String = ""
    
    // A boolean flag indicating whether to show a fail message.
    @Published var showFailMessage = false
    @Published var shouldNavigate = false
    @Published var showInvalidDateMessage = false
    
    // to initialize the income data and income history data
    init() {
        loadIncomeData()
        loadIncomeHistory()
    }
    
    // function to load the data of income from the json data
    func loadIncomeData() {
        let url = Bundle.main.url(forResource: "incomeData", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.income = try! decoder.decode([Income].self, from: jsonData)
    }
    
    // function to load the data from the income history
    func loadIncomeHistory() {
        if let data = UserDefaults.standard.data(forKey: "incomeHistory") {
            if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                self.incomeHistory = decodedData
                self.index = incomeHistory.count
            }
        }
    }
    
    // function to save the income history
    func saveIncomeHistory() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedData, forKey: "incomeHistory")
        }
    }
    
    // function to check if the amount is valid (if the amount being inputted is greater than 0)
    func validateAmount() {
        self.check = ((Int(amount) ?? 0) >= 1)
    }
    
    // function to delete the income history
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Income" {
            incomeHistory.remove(atOffsets: offsets)
        }
        // update the changes of the history data for income after a data is being deleted
        saveIncomeHistory()
    }
    
    // function to get the index of the history
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
    
    // function to save the income
    func saveIncome() {
        // if the income category is not selected, then it will show an error message and the data will not be saved
        if selectedOption == nil {
            showFailMessage = true
            appendIncome = false
        } else {
            // if the income category is selected, then it will not show an error message and the data will be saved
            if check {
                withAnimation(.easeInOut) {
                    incomeHistory.append(History(id: index, category: selectedOption?.incomeCategory ?? "", amount: Int(amount) ?? 0, date: date, type: type, name: name))
                    saveIncomeHistory()
                    appendIncome = true
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
