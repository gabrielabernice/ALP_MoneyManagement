//
//  InputIncome.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI

struct InputIncome: View {
    @State var income: [Income] = []
    @State var selectedOption: Income?
    
    @State var amount: String = ""
    @State var check: Bool = false
    
    @State var date = Date()
    @State var isExpanded = false
    
    @State var incomeHistory: [History] = []
    @State var appendIncome = false
    
    @State var index = 0
    @State var type = "Income"
    
    @State var name : String = ""
    
    
    @State private var failMessage: String = ""
    @State private var showFailMessage: Bool = false
    
    var body: some View {
        //        NavigationView {
        VStack {
            Group {
                Text("test")
            }
            Group {
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
                
                Text("Source of Income : \n\(selectedOption?.incomeCategory ?? "")")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Menu {
                    ForEach(income, id: \.self) { incomes in
                        Button(action: {
                            selectedOption = incomes
                        }) {
                            Text(incomes.incomeCategory)
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
                    
                    TextField("ex : 50000", text: $amount)
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
                
                
                
                Button("Save") {
                    if selectedOption == nil {
                        // Tampilkan pesan kesalahan karena opsi belum dipilih
                        failMessage = "Please select an option"
                        showFailMessage = true
                    } else {
                        if check {
                            incomeHistory.append(History(id: index, category: selectedOption?.incomeCategory ?? "", amount: Int(amount) ?? 0, date: date, type: type, name: name))
                            // Simpan data ke UserDefaults
                            let encoder = JSONEncoder()
                            if let encodedData = try? encoder.encode(incomeHistory) {
                                UserDefaults.standard.set(encodedData, forKey: "incomeHistory")
                            }
                            
                            appendIncome = true
                            index += 1
                        }
                    }
                }
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.4, green: 0.6, blue: 1.0))
                .cornerRadius(10)
                .disabled(!check)
                
                
                if appendIncome{
                    Text("Data successfully saved!")
                        .padding()
                        .multilineTextAlignment(.center)
                }else if showFailMessage {
                    Text(failMessage)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            
            
            
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: "incomeHistory") {
                if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                    incomeHistory = decodedData
                    index = incomeHistory.count
                }
            }
            
            let url = Bundle.main.url(forResource: "incomeData", withExtension: "json")!
            let jsonData = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            income = try! decoder.decode([Income].self, from: jsonData)
        }
        //        }
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

struct InputIncome_Previews: PreviewProvider {
    static var previews: some View {
        InputIncome()
    }
}
