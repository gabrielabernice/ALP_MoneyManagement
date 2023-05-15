//
//  Expenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import Foundation

struct Expenses: Hashable, Codable, Identifiable{
    var id: Int
    var expensesCategory: String
}
