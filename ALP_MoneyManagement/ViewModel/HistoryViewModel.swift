//
//  HistoryViewModel.swift
//  ALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 30/05/23.
//

import Foundation
import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var incomeHistory: [History] = []
    @Published var expensesHistory: [History] = []

    // function to delete the history of income and expenses
    func deleteHistory(at offsets: IndexSet, type: String) {
        if type == "Income" {
            incomeHistory.remove(atOffsets: offsets)
        } else if type == "Expenses" {
            expensesHistory.remove(atOffsets: offsets)
        }

        saveDataToUserDefaults()
    }

    // function to save the data to history
    func saveDataToUserDefaults() {
        let encoder = JSONEncoder()

        if let encodedIncomeData = try? encoder.encode(incomeHistory) {
            UserDefaults.standard.set(encodedIncomeData, forKey: "incomeHistory")
        }

        if let encodedExpensesData = try? encoder.encode(expensesHistory) {
            UserDefaults.standard.set(encodedExpensesData, forKey: "expensesHistory")
        }
    }

    // function to load all the data of income and expenses
    func loadDataFromUserDefaults() {
        if let incomeData = UserDefaults.standard.data(forKey: "incomeHistory") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([History].self, from: incomeData) {
                incomeHistory = decodedData
            }
        }

        if let expensesData = UserDefaults.standard.data(forKey: "expensesHistory") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([History].self, from: expensesData) {
                expensesHistory = decodedData
            }
        }
    }

    // function to get the index of the history (income and expenses)
    func getIndex(for history: History, in array: [History]) -> Int {
        guard let index = array.firstIndex(where: { $0.id == history.id }) else {
            fatalError("History not found")
        }
        return index
    }
}
