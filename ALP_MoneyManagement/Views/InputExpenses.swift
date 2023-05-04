//
//  InputExpenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct InputExpenses: View {
//    @EnvironmentObject var modelData: ModelData
//    static let modelData = ModelData()
    
    @State var expenses: [Expenses] = []
    @State var selectedOption: Expenses?
    
    @State var amount: String = ""
    @State var check: Bool = false
    
    @State var date = Date()
    @State var isExpanded = false
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Source of Expenses : \(selectedOption?.expensesName ?? "")")
                    .font(.title2)
                
                Menu {
                    ForEach(expenses, id: \.self) { expense in
                        Button(action: {
                            selectedOption = expense
                        }) {
                            Text(expense.expensesName)
                        }
                    }
                } label: {
                    Label("Select an option", systemImage: "arrowtriangle.down.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.6, blue: 1.0))
                        .padding(.bottom)
                }
                
                Text("Amount : ")
                    .font(.title2)
                
                HStack{
                    Text("Rp. ")
                        .font(.title2)
                    
                    TextField("Enter Amount", text: $amount)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .font(.system(size: 16, weight: .bold))
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.3), lineWidth: 2)
                        )
                        .keyboardType(.numberPad)
                }
                
                if !check{
                    Text("Please enter a valid amount\n(only numbers above 0)")
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Text("Date: \(date, formatter: dateFormatter)")
                    .font(.title2)
                
                Button(action: {
                    isExpanded.toggle()
                }, label: {
                    Text("Select a date")
                        .padding(.bottom)
                })
                
                if isExpanded {
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                }
                
                NavigationLink(destination: MainScreen(savings: "")) {
                    Text("Save")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.6, blue: 1.0))
                        .cornerRadius(10)
                }
                .disabled(!check)
            }
            .onAppear {
                let url = Bundle.main.url(forResource: "expensesData", withExtension: "json")!
                let jsonData = try! Data(contentsOf: url)
                let decoder = JSONDecoder()
                expenses = try! decoder.decode([Expenses].self, from: jsonData)
            }
        }
        .onChange(of: amount) { newValue in
            check = ((Int(newValue) ?? 0) >= 1)
        }
        .padding(.horizontal, 30)
        .bold()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

struct InputExpenses_Previews: PreviewProvider {
    static var previews: some View {
        InputExpenses()
    }
}
