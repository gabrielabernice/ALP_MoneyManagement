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
    
    init() {
        loadExpensesData()
        loadExpensesHistory()
    }
    
    func loadExpensesData() {
        let url = Bundle.main.url(forResource: "expensesData", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.expenses = try! decoder.decode([Expenses].self, from: jsonData)
    }
    
    func loadExpensesHistory() {
        if let data = UserDefaults.standard.data(forKey: "expensesHistory") {
            if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                self.expensesHistory = decodedData
                self.index = expensesHistory.count
            }
        }
    }
    
    func saveExpensesHistory() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedData, forKey: "expensesHistory")
        }
    }
    
    func validateAmount() {
        self.check = ((Int(amount) ?? 0) >= 1)
    }
    
    func saveExpenses() {
        if selectedOption == nil {
            showFailMessage = true
            appendExpenses = false
        } else {
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
