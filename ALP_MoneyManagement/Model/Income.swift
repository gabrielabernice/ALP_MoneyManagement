//
//  Income.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import Foundation

// This is the model structure for representing income data.
struct Income: Hashable, Codable, Identifiable{
    var id: Int
    var incomeCategory: String
}

// The Income model includes properties for id and incomeCategory. It conforms to the Hashable, Codable, and Identifiable protocols. The Hashable and Codable protocols enable the model to be used in sets and encoded/decoded from data, respectively. The Identifiable protocol assigns a unique identifier to each instance of the Income struct.
