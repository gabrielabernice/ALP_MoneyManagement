//
//  ModelData.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    
    // The income property represents an array of Income objects,
    @Published var income: [Income] = load("incomeData.json")
    // The expenses property represents an array of Expenses objects
    @Published var expenses: [Expenses] = load("expensesData.json")
}

//  The load function is a generic function that takes a filename as input and returns an object of type T, which must conform to the Decodable protocol

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        // If any error occurs during the loading or parsing process, a fatalError is triggered with an appropriate error message.
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        // If any error occurs during the loading or parsing process, a fatalError is triggered with an appropriate error message.
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        // If any error occurs during the loading or parsing process, a fatalError is triggered with an appropriate error message.
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
