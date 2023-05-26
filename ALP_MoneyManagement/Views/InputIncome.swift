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
    
    @State var showFailMessage = false
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading, spacing: 30){
                    Text("Input Income")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, -50)
                        .offset(x: 12)
                    
                    VStack(spacing: -5) {
                        Text("Date ")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .padding()
                            .overlay(
                                HStack{
                                    Text("\(date, formatter: dateFormatter)")
                                    
                                    
                                    Spacer().frame(width: 85)
                                    
                                    Button(action: {
                                        isExpanded.toggle()
                                    }, label: {
                                        Text("Select a date")
                                            .padding()
                                        
                                    })
                                    
                                }
                            )
                        
                        if isExpanded {
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                    .padding(.bottom, -20)
                    
                    VStack(spacing: -5){
                        Text("Source of Income")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .padding()
                            .overlay(
                                HStack{
                                    Text("\(selectedOption?.incomeCategory ?? "")")
                                    Spacer().frame(width: 85)
                                    
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
                                        
                                    }
                                    
                                }
                            )
                        
                    }
                    .padding(.bottom, -33)
                    
                    VStack(spacing: -8){
                        
                        Text("Amount")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x:-12)
                        
                        TextField("ex : 50000", text: $amount)
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(10)
                            .frame(width: 350, height: 90)
                            .font(.system(size: 16, weight: .bold))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)
                        
                        Text("*Only numbers above 0")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .opacity(!check ? 1 : 0)
                        
                        
                    }
                    .padding()
                    .padding(.bottom, -50)
                    
                    VStack(spacing: -5){
                        
                        Text("Note ")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x:-12)
                        
                        TextField("Mcd", text: $name)
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(10)
                            .frame(width: 350, height: 90)
                            .font(.system(size: 16, weight: .bold))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)
                        
                    }
                    .padding()
                    
                    
                    
                    
                    //batas vstack 1 untuk form
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
                .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                .background(Color(hex: 0x6DA3FF))
                .clipShape(BottomRoundedRectangle(radius:55))
                .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                //                .onChange
                
//                HStack{}.frame(height: -20)
                
                
                    Text("Data successfully saved!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .offset(y: 10)
                        .opacity(appendIncome == true ? 1.0 : 0.0)
                        .opacity(showFailMessage == false ? 1:0)
                
              
                    Text("Please select an option")
                        .multilineTextAlignment(.center)
                        .offset(y: -40)
                        .opacity(appendIncome == false ? 1:0)
                        .opacity(showFailMessage == true ? 1.0 : 0.0)
                        
                
                
                Button("Save") {
                    if selectedOption == nil {
                        // Tampilkan pesan kesalahan karena opsi belum dipilih
//                        failMessage = "Please select an option"
                        showFailMessage = true
                        appendIncome = false
                    } else {
                        if check {
                            incomeHistory.append(History(id: index, category: selectedOption?.incomeCategory ?? "", amount: Int(amount) ?? 0, date: date, type: type, name: name))
                            // Simpan data ke UserDefaults
                            let encoder = JSONEncoder()
                            if let encodedData = try? encoder.encode(incomeHistory) {
                                UserDefaults.standard.set(encodedData, forKey: "incomeHistory")
                            }
                            
                            appendIncome = true
                            showFailMessage = false
                            index += 1
                        }
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.9)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .background(Color(hex: 0x6DA3FF))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .fontWeight(.bold)
                .padding(.bottom, 60)
                .offset(y: -10)
                .disabled(!check)
                
                
                
                
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
        }
        .onChange(of: amount) { newValue in
            check = ((Int(newValue) ?? 0) >= 1)
        }
        .ignoresSafeArea(.all)
    
    }
    
    struct BottomRoundedRectangle: Shape {
        var radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let width = rect.size.width
            let height = rect.size.height
            
            // Determine the corner radius
            let cornerRadius = min(min(radius, height/2), width/2)
            
            // Create a rectangle with the bottom corners rounded
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            path.closeSubpath()
            
            return path
        }
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
