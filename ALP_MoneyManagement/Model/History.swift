//
//  History.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation

// This is the model structure for representing history data.
struct History: Hashable, Codable, Identifiable{
    var id: Int
    var category: String
    var amount: Int
    var date: Date
    var type: String
    var name: String
}

// The History model includes properties for id, category, amount, date, type, and name. It conforms to the Hashable, Codable, and Identifiable protocols. The Hashable and Codable protocols enable the model to be used in sets and encoded/decoded from data, respectively. The Identifiable protocol assigns a unique identifier to each instance of the History struct.
