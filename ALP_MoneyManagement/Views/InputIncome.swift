//
//  InputIncome.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI
import Dispatch
import UIKit

struct InputIncome: View {
    @StateObject private var viewModel = InputIncomeViewModel()
    
    // State property to control the visibility of the alert
    @State private var showAlert = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @State private var isShowingInputIncome = true
    @Environment(\.presentationMode) var presentationMode
    
    var isDateInFuture: Bool {
        return viewModel.date > Date()
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView{
                    VStack {
                        ScrollView{
                            VStack(alignment: .leading, spacing: 30){
                                Text("Input Income")
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
                                    if UIDevice.current.userInterfaceIdiom == .pad {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white)
                                            .frame(width: geometry.size.width - 40, height: 50) // Adjusted the width here
                                            .padding()
                                            .overlay(
                                                HStack{
                                                    // to show the date that is being picked
                                                    Text("\(viewModel.date, formatter: dateFormatter)")
                                                    
                                                    Spacer().frame(width: geometry.size.width/1.6)
                                                    
                                                    // to make the button for the date picker
                                                    Button(action: {
                                                        if viewModel.date > Date() {
                                                            viewModel.showInvalidDateMessage = true
                                                        } else {
                                                            viewModel.isExpanded.toggle()
                                                            viewModel.showInvalidDateMessage = false
                                                        }
                                                    }, label: {
                                                        Text("Select a date")
                                                            .padding()
                                                    })
                                                    .disabled(viewModel.date > Date() && !viewModel.isExpanded)
                                                }
                                            )
                                    }else{
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
                                                        if viewModel.date > Date() {
                                                            viewModel.showInvalidDateMessage = true
                                                        } else {
                                                            viewModel.isExpanded.toggle()
                                                            viewModel.showInvalidDateMessage = false
                                                        }
                                                    }, label: {
                                                        Text("Select a date")
                                                            .padding()
                                                    })
                                                    .disabled(viewModel.date > Date() && !viewModel.isExpanded)
                                                }
                                            )
                                    }
                                    
                                    // if the button is being expanded, the date picker with a wheel style will be expanded, showing the dates
                                    if viewModel.isExpanded {
                                        DatePicker(
                                            "",
                                            selection: $viewModel.date,
                                            displayedComponents: [.date]
                                        )
                                        .datePickerStyle(WheelDatePickerStyle())
                                    }
                                    
                                    if viewModel.date > Date() {
                                        // Show an error message if the selected date is in the future
                                        Text("Please select a valid date")
                                            .font(.system(size: 20))
                                            .foregroundColor(.red)
                                            .font(.caption)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.top,10)
                                            .padding(.horizontal, 10)
                                            .font(.title)
                                    }
                                    
                                }
                                .padding(.bottom, -20)
                                
                                // for inputting the income category
                                VStack(spacing: -5){
                                    Text("Source of Income")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x: 12)
                                    
                                    if UIDevice.current.userInterfaceIdiom == .pad {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white)
                                            .frame(width: geometry.size.width - 40, height: 50) // Adjusted the width here
                                            .padding()
                                            .overlay(
                                                HStack{
                                                    // to show the selected income category
                                                    Text("\(viewModel.selectedOption?.incomeCategory ?? "")")
                                                    Spacer().frame(width: geometry.size.width/1.5)
                                                    
                                                    // showing all the income category by looping, making it in the form of dropdownn list
                                                    Menu {
                                                        ForEach(viewModel.income, id: \.self) { incomes in
                                                            Button(action: {
                                                                viewModel.selectedOption = incomes
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
                                    }else{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white)
                                            .frame(width: geometry.size.width - 40, height: 50) // Adjusted the width here
                                            .padding()
                                            .overlay(
                                                HStack{
                                                    // to show the selected income category
                                                    Text("\(viewModel.selectedOption?.incomeCategory ?? "")")
                                                    Spacer().frame(width: 135)
                                                    
                                                    // showing all the income category by looping, making it in the form of dropdownn list
                                                    Menu {
                                                        ForEach(viewModel.income, id: \.self) { incomes in
                                                            Button(action: {
                                                                viewModel.selectedOption = incomes
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
                                }
                                .padding(.bottom, -33)
                                
                                // to input the amount of the income
                                VStack(spacing: -8){
                                    Text("Amount")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x:12)
                                    
                                    // textfield to let the user input the amount of income
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
                                
                                // to input the note about the income
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
                        .background(Color(hex: 0x6DA3FF).opacity(0.8))
                        .clipShape(BottomRoundedRectangle(radius:55))
                        .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                        
                        // a text to show when a data is not completed yet, if the user havent input the income category and amount, the text will be seen (opacity set to 1)
                        Text("Please select an option")
                            .multilineTextAlignment(.center)
                            .opacity(viewModel.appendIncome == false ? 1:0)
                            .opacity(viewModel.showFailMessage == true ? 1.0 : 0.0)
                        
                        Button("Save") {
                            
                            if viewModel.selectedOption == nil {
                                // Show failed message
                                alertMessage = "Failed to save data. Please select an option."
                            } else if viewModel.date > Date(){
                                viewModel.showInvalidDateMessage = true
                            }
                            else {
                                if viewModel.check {
                                    // Save data
                                    withAnimation(.easeInOut) {
                                        viewModel.incomeHistory.append(History(id: viewModel.index, category: viewModel.selectedOption?.incomeCategory ?? "", amount: Int(viewModel.amount) ?? 0, date: viewModel.date, type: viewModel.type, name: viewModel.name))
                                        let encoder = JSONEncoder()
                                        if let encodedData = try? encoder.encode(viewModel.incomeHistory) {
                                            UserDefaults.standard.set(encodedData, forKey: "incomeHistory")
                                        }
                                        
                                        viewModel.appendIncome = true
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
                        .alert(isPresented: $isShowingAlert) {
                            Alert(title: Text(alertMessage),
                                  dismissButton: .default(Text("OK"), action: {
                                // Setelah tombol OK ditekan, atur `isShowingInputExpenses` menjadi `false` setelah 2 detik
                                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                    isShowingInputIncome = false
                                    presentationMode.wrappedValue.dismiss()
                                }
                            })
                            )
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.9)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .background(Color(hex: 0x6DA3FF))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .fontWeight(.bold)
                        .padding(.top, 50) // Adjusted the top padding here
                        .disabled(!viewModel.check || viewModel.showInvalidDateMessage || isDateInFuture)// the button for saving the data will be disabled if it doesnt fullfil the requirement
                        .overlay(
                            NavigationLink(
                                destination: AllIncomeView(),
                                label: {
                                    EmptyView()
                                })
                            .hidden()
                        )
                    }
                    
                    // to call the functions when the view screen shows up
                    .onAppear {
                        viewModel.loadIncomeData()
                        viewModel.loadIncomeHistory()
                    }
                }
                // will be called when the value of amount is changed, to pass the new value
                .onChange(of: viewModel.amount) { newValue in
                    viewModel.validateAmount()
                }
                //  scroll view will extend to the edges of the screen, disregarding the safe area insets
                .ignoresSafeArea(.all)
            }
        }
        // Apply stack navigation view style to display the navigation hierarchy
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // a custom shape in SwiftUI that creates a rectangular shape with rounded corners at the bottom
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

struct InputIncome_Previews: PreviewProvider {
    static var previews: some View {
        InputIncome()
    }
}
