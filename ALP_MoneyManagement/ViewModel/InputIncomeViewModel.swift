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
    @Published var income: [Income] = []
    @Published var selectedOption: Income?
    
    @Published var amount: String = ""
    @Published var check: Bool = false
    
    @Published var date = Date()
    @Published var isExpanded = false
    
    @Published var incomeHistory: [History] = []
    @Published var appendIncome = false
    
    @Published var index = 0
    @Published var type = "Income"
    
    @Published var name : String = ""
    
    @Published var showFailMessage = false
    @Published var shouldNavigate = false
    
    init() {
        loadIncomeData()
        loadIncomeHistory()
    }
    
    func loadIncomeData() {
        let url = Bundle.main.url(forResource: "incomeData", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.income = try! decoder.decode([Income].self, from: jsonData)
    }
    
    func loadIncomeHistory() {
        if let data = UserDefaults.standard.data(forKey: "incomeHistory") {
            if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                self.incomeHistory = decodedData
                self.index = incomeHistory.count
            }
        }
    }
    
    func saveIncomeHistory() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedData, forKey: "incomeHistory")
        }
    }
    
    func validateAmount() {
        self.check = ((Int(amount) ?? 0) >= 1)
    }
    
    func saveIncome() {
        if selectedOption == nil {
            showFailMessage = true
            appendIncome = false
        } else {
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
