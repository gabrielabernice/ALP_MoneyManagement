//
//  InputExpenses.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI
import Dispatch
import UIKit

struct InputExpenses: View {
    @StateObject private var viewModel = InputExpensesViewModel()
    @State private var isShowingAlert = false
        @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView{
                    VStack {
                        ScrollView{
                            VStack(alignment: .leading, spacing: 30){
                                Text("Input Expenses")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 20)
                                    .offset(x: 12)
                                
                                // for the date input
                                VStack(spacing: -5) {
                                    Text("Date ")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x:12)
                                    
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.white)
                                        .frame(width: geometry.size.width - 40, height: 50) // Adjusted the width here
                                        .padding()
                                        .overlay(
                                            HStack{
                                                // to show the date that is being picked
                                                Text("\(viewModel.date, formatter: dateFormatter)")
                                                
                                                Spacer().frame(width: 85)
                                                
                                                // to make the button for the date picker
                                                Button(action: {
                                                    viewModel.isExpanded.toggle()
                                                }, label: {
                                                    Text("Select a date")
                                                        .padding()
                                                    
                                                })
                                            }
                                        )
                                    
                                    // if the button is being expanded, the date picker with a wheel style will be expanded, showing the dates
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
                                
                                // for inputting the expenses category
                                VStack(spacing: -5){
                                    Text("Source of Expenses")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x: 12)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.white)
                                        .frame(width: geometry.size.width - 40, height: 50) // Adjusted the width here
                                        .padding()
                                        .overlay(
                                            HStack{
                                                // to show the selected expenses category
                                                Text("\(viewModel.selectedOption?.expensesCategory ?? "")")
                                                Spacer().frame(width: 85)
                                                
                                                // showing all the expenses category by looping, making it in the form of dropdownn list
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
                                
                                // to input the amount of the expenses
                                VStack(spacing: -8){
                                    Text("Amount")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x:12)
                                    
                                    // textfield to let the user input the amount of expenses
                                    TextField("ex : 50000", text: $viewModel.amount)
                                        .padding()
                                        .background(Color(.white))
                                        .cornerRadius(10)
                                        .frame(width: geometry.size.width - 40, height: 90) // Adjusted the width here
                                        .font(.system(size: 16, weight: .bold))
                                        .cornerRadius(10)
                                        .keyboardType(.numberPad)
                                    
                                    // error warning that is going to be shown for the error handling, the opacity will be turned to 0 (unseen) if the user's input doesnt meet the requirement
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
                                
                                // to input the note about the expenses
                                VStack(spacing: -5){
                                    Text("Note ")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x:12)
                                    
                                    // text field to let the user to input the notes
                                    TextField("Mcd", text: $viewModel.name)
                                        .padding()
                                        .background(Color(.white))
                                        .cornerRadius(10)
                                        .frame(width: geometry.size.width - 40, height: 90) // Adjusted the width here
                                        .font(.system(size: 16, weight: .bold))
                                        .cornerRadius(10)
                                        .keyboardType(.numberPad)
                                }
                                .padding()
                                // max part of main vstack for the form
                            }
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, 20)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                        .background(Color(hex: 0xF89385).opacity(0.8))
                        .clipShape(BottomRoundedRectangle(radius:55))
                        .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                        
                        // a text to show when a data is successfully saved, if the user already input the expenses category and amount, the text will be seen (opacity set to 1)
//                        Text("Data successfully saved!")
//                            .padding()
//                            .multilineTextAlignment(.center)
//                            .opacity(viewModel.appendExpenses == true ? 1.0 : 0.0)
//                            .opacity(viewModel.showFailMessage == false ? 1:0)
                        
                        // a text to show when a data is not completed yet, if the user havent input the expenses category and amount, the text will be seen (opacity set to 1)
                        Text("Please select an option")
                            .multilineTextAlignment(.center)
                            .opacity(viewModel.appendExpenses == false ? 1:0)
                            .opacity(viewModel.showFailMessage == true ? 1.0 : 0.0)
                        
                        // button to let the user to save the data when they already meet the requirements
                        Button("Save") {
                            if viewModel.selectedOption == nil {
                                // Show failed message
                                alertMessage = "Failed to save data. Please select an option."
                            } else {
                                if viewModel.check {
                                    // Save data
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
                                    
                                    // Show success message
                                    alertMessage = "Data saved successfully!"
                                } else {
                                    // Show failed message
                                    alertMessage = "Failed to save data. Please enter a valid amount."
                                }
                            }
                            
                            isShowingAlert = true
                        }
                        
                        .padding()
                        .frame(width: geometry.size.width * 0.9)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .background(Color(hex: 0xF89385))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .fontWeight(.bold)
//                        .padding(.bottom, 90)
                        .padding(.top, 10)
                        .offset(y: -10)
                        .disabled(!viewModel.check) // the button for saving the data will be disabled if it doesnt fullfil the requirement
                        .overlay(
                            NavigationLink(
                                destination: AllExpensesView(),
                                label: {
                                    EmptyView()
                                })
                            .hidden()
                        )
                    }
                    .alert(isPresented: $isShowingAlert) {
                                Alert(
                                    title: Text(alertMessage),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                    // to call the functions when the view screen shows up
                    .onAppear {
                        viewModel.loadExpensesData()
                    }
                }
                // will be called when the value of amount is changed, to pass the new value
                .onChange(of: viewModel.amount) { newValue in
                    viewModel.check = ((Int(newValue) ?? 0) >= 1)
                }
                .ignoresSafeArea(.all)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
    
    // to make the format of the date picker, using the long date style, and not recording the time
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
