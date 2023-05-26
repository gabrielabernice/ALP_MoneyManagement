//
//  InputExpenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct InputExpenses: View {
    @State var expenses: [Expenses] = []
    @State var selectedOption: Expenses?
    
    @State var amount: String = ""
    @State var check: Bool = false
    
    @State var date = Date()
    @State var isExpanded = false
    
    @State var expensesHistory: [History] = []
    @State var appendExpenses = false
    
    @State var index = 0
    @State var type = "Expenses"
    
    @State var name : String = ""
    
    var body: some View {
//        NavigationView {
            VStack {
                Text("Source of Expenses: \n\(selectedOption?.expensesCategory ?? "")")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Menu {
                    ForEach(expenses, id: \.self) { expense in
                        Button(action: {
                            selectedOption = expense
                        }) {
                            Text(expense.expensesCategory)
                        }
                    }
                } label: {
                    Label("Select an option", systemImage: "arrowtriangle.down.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.6, blue: 1.0))
                        .padding(.bottom)
                }
                
                Text("Amount:")
                    .font(.title2)
                
                HStack {
                    Text("Rp.")
                        .font(.title2)
                    
                    TextField("ex: 30000", text: $amount)
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
                
                if !check {
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
                
                Button("Save") {
                    if check {
                        expensesHistory.append(History(id: index, category: selectedOption?.expensesCategory ?? "", amount: Int(amount) ?? 0, date: date, type: type, name:name))
                        // Simpan data ke UserDefaults
                        let encoder = JSONEncoder()
                        if let encodedData = try? encoder.encode(expensesHistory) {
                            UserDefaults.standard.set(encodedData, forKey: "expensesHistory")
                        }
                        
                        appendExpenses = true
                        index += 1
                    }
                }
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.4, green: 0.6, blue: 1.0))
                .cornerRadius(10)
                .disabled(!check)
                
                if appendExpenses {
                    Text("Data successfully saved!")
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: "expensesHistory") {
                    if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                        expensesHistory = decodedData
                        index = expensesHistory.count
                    }
                }
                
                let url = Bundle.main.url(forResource: "expensesData", withExtension: "json")!
                let jsonData = try! Data(contentsOf: url)
                let decoder = JSONDecoder()
                expenses = try! decoder.decode([Expenses].self, from: jsonData)
//            }
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
