//
//  History.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation

struct History: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
    var amount: Int
    var date: Date
    var type: String
}
