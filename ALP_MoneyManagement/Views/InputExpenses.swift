//
//  InputExpenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//
import SwiftUI
import Dispatch

struct InputExpenses: View {
    @StateObject private var viewModel = InputExpensesViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    VStack(alignment: .leading, spacing: 30){
                        Text("Input Expenses")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, -8)
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
                                        Text("\(viewModel.date, formatter: dateFormatter)")
                                        
                                        Spacer().frame(width: 85)
                                        
                                        Button(action: {
                                            viewModel.isExpanded.toggle()
                                        }, label: {
                                            Text("Select a date")
                                                .padding()
                                                .foregroundColor(Color(hex: 0xF89385))
                                            
                                        })
                                    }
                                )
                            
                            if viewModel.isExpanded {
                                DatePicker(
                                    "",
                                    selection: $viewModel.date,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(WheelDatePickerStyle())
                            }
                        }
                        .padding(.bottom, -20)
                        
                        VStack(spacing: -5){
                            Text("Source of Expenses")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.white)
                                .frame(width: 350, height: 50)
                                .padding()
                                .overlay(
                                    HStack{
                                        Text("\(viewModel.selectedOption?.expensesCategory ?? "")")
                                        Spacer().frame(width: 85)
                                        
                                        Menu {
                                            ForEach(viewModel.expenses, id: \.self) { expense in
                                                Button(action: {
                                                    viewModel.selectedOption = expense
                                                }) {
                                                    Text(expense.expensesCategory)
                                                }
                                            }
                                        } label: {
                                            Label("Select an option", systemImage: "arrowtriangle.down.fill")
                                                .foregroundColor(Color(hex: 0xF89385))
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
                            
                            TextField("ex : 50000", text: $viewModel.amount)
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
                                .opacity(!viewModel.check ? 1 : 0)
                        }
                        .padding()
                        .padding(.bottom, -50)
                        
                        VStack(spacing: -5){
                            Text("Note ")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(x:-12)
                            
                            TextField("Mcd", text: $viewModel.name)
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
                    .padding(.horizontal, 20)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .background(Color(hex: 0xF89385).opacity(0.8))
                    .clipShape(BottomRoundedRectangle(radius:55))
                    .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                    
                    Text("Data successfully saved!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .offset(y: 10)
                        .opacity(viewModel.appendExpenses == true ? 1.0 : 0.0)
                        .opacity(viewModel.showFailMessage == false ? 1:0)
                    
                    Text("Please select an option")
                        .multilineTextAlignment(.center)
                        .offset(y: -40)
                        .opacity(viewModel.appendExpenses == false ? 1:0)
                        .opacity(viewModel.showFailMessage == true ? 1.0 : 0.0)
                    
                    Button("Save") {
                        if viewModel.selectedOption == nil {
                            viewModel.showFailMessage = true
                            viewModel.appendExpenses = false
                        } else {
                            if viewModel.check {
                                withAnimation(.easeInOut) {
                                    viewModel.expensesHistory.append(History(id: viewModel.index, category: viewModel.selectedOption?.expensesCategory ?? "", amount: Int(viewModel.amount) ?? 0, date: viewModel.date, type: viewModel.type, name: viewModel.name))
                                    let encoder = JSONEncoder()
                                    if let encodedData = try? encoder.encode(viewModel.expensesHistory) {
                                        UserDefaults.standard.set(encodedData, forKey: "expensesHistory")
                                    }
                                    
                                    viewModel.appendExpenses = true
                                    viewModel.showFailMessage = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        viewModel.shouldNavigate = true
                                    }
                                    viewModel.index += 1
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .background(Color(hex: 0xF89385))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .fontWeight(.bold)
                    .padding(.bottom, 90)
                    .padding(.top, -50)
                    .offset(y: -10)
                    .disabled(!viewModel.check)
                    .overlay(
                        NavigationLink(
                            destination: AllExpensesView(),
                            label: {
                                EmptyView()
                            })
                        .hidden()
                    )
                }
                .onAppear {
                    if let data = UserDefaults.standard.data(forKey: "expensesHistory") {
                        if let decodedData = try? JSONDecoder().decode([History].self, from: data) {
                            viewModel.expensesHistory = decodedData
                            viewModel.index = viewModel.expensesHistory.count
                        }
                    }
                    
                    let url = Bundle.main.url(forResource: "expensesData", withExtension: "json")!
                    let jsonData = try! Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    viewModel.expenses = try! decoder.decode([Expenses].self, from: jsonData)
                }
            }
            .onChange(of: viewModel.amount) { newValue in
                viewModel.check = ((Int(newValue) ?? 0) >= 1)
            }
            .ignoresSafeArea(.all)
        }
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
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

struct InputExpenses_Previews: PreviewProvider {
    static var previews: some View {
        InputExpenses()
    }
}
