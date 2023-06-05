//
//  Expenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import Foundation

// This is the model structure for representing expenses data.
struct Expenses: Hashable, Codable, Identifiable{
    var id: Int
    var expensesCategory: String
}

// The Expenses model includes properties for id and expensesCategory. It conforms to the Hashable, Codable, and Identifiable protocols. The Hashable and Codable protocols enable the model to be used in sets and encoded/decoded from data, respectively. The Identifiable protocol assigns a unique identifier to each instance of the Expenses struct.
