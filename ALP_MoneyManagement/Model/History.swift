//
//  History.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation

struct History: Hashable, Codable, Identifiable{
    var id: Int
    var category: String
    var amount: Int
    var date: Date
    var type: String
    var name: String
}
