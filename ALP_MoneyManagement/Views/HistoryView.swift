//
//  HistoryView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct HistoryView: View {
//    @State var SavingsHistory: [Savings] = []
    @State var history: [History] = []
    
    var body: some View {
        VStack {
            Text("History")
                .font(.title)
            ForEach(history, id: \.self) { expense in
                Text("\(expense.name) - Rp. \(expense.amount) - \(expense.date, formatter: dateFormatter)")
            }
            Text("This feature is still developing\nPlease wait for an App update in the future")
                .multilineTextAlignment(.center)
                .padding(.vertical)
        }
        .bold()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

struct HistoryView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        HistoryView()
    }
