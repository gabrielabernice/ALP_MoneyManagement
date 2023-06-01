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
    @State private var showAlert = false
    
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
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.white)
                                        .frame(width: 350, height: 50)
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
                                
                                // for inputting the income category
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
                                                // to show the selected income category
                                                Text("\(viewModel.selectedOption?.incomeCategory ?? "")")
                                                Spacer().frame(width: 85)
                                                
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
                                .padding(.bottom, -33)
                                
                                // to input the amount of the income
                                VStack(spacing: -8){
                                    Text("Amount")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .offset(x:-12)
                                    
                                    // textfield to let the user input the amount of income
                                    TextField("ex : 50000", text: $viewModel.amount)
                                        .padding()
                                        .background(Color(.white))
                                        .cornerRadius(10)
                                        .frame(width: 350, height: 90)
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
                                        .offset(x:-12)
                                    
                                    // text field to let the user to input the notes
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
                                        viewModel.saveIncome()
                                        showAlert = true
                                    }
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("Data successfully saved"), dismissButton: .default(Text("OK")))
                                    }
                        .padding()
                        .frame(width: geometry.size.width * 0.9)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .background(Color(hex: 0x6DA3FF))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .fontWeight(.bold)
                        .padding(.top, 10) // Adjusted the top padding here
                        .disabled(!viewModel.check) // the button for saving the data will be disabled if it doesnt fullfil the requirement
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
                .ignoresSafeArea(.all)
            }
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
