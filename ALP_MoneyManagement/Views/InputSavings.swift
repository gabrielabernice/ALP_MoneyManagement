//
//  InputSavings.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 04/05/23.
//

import SwiftUI

struct InputSavings: View {
    @State var amount: String = ""
    @State var days: String = ""
    
    @State var checkAmount: Bool = false
    @State var checkDays: Bool = false
    
    @State var perDay = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Add your Goal")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity)
                    
                    // to let the user to input the target amount of money they want to save
                    VStack(alignment:.leading, spacing: -5) {
                        Text("Savings Target")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        // textfield to allow the user to input their target amount of money
                        TextField("Rp", text: formatAmount(amount))
                            .padding()
                            .font(.system(size: 16, weight: .bold))
                            .background(Color(.white))
                            .cornerRadius(10)
                        //size for ipad
                            .frame(maxWidth: .infinity)
                            .frame(height: 90)
                            .keyboardType(.numberPad)
                        
                        // error warning that is going to be shown for the error handling, the opacity will be turned to 0 (unseen) if the user's input doesnt meet the requirement
                        Text("*Only numbers above 0")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .opacity(!checkAmount ? 1 : 0)
                    }
                    
                    // to let the user to input the target day
                    VStack(alignment:.leading, spacing: -5) {
                        Text("Target Day")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        // textfield to allow the user to input their target of day
                        TextField("Day", text: $days)
                            .padding()
                            .font(.system(size: 16, weight: .bold))
                            .background(Color(.white))
                            .cornerRadius(10)
                        //size for ipad
                            .frame(maxWidth: .infinity)
                            .frame(height: 90)
                            .keyboardType(.numberPad)

                        // error warning that is going to be shown for the error handling, the opacity will be turned to 0 (unseen) if the user's input doesnt meet the requirement
                        Text("*Only numbers above 0")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .font(.title)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .opacity(!checkDays ? 1 : 0)
                    }
                    Spacer()
                }
                .padding(.top, 80)
                .padding(.horizontal, 40)
                .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                .background(Color(hex: 0x6DA3FF).opacity(0.8))
                .clipShape(BottomRoundedRectangle(radius:55))
                .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                .onChange(of: amount) { newValue in
                    checkAmount = ((Int(newValue) ?? 0) >= 1)
                }
                // will be called when the value of amount is changed, to pass the new value
                .onChange(of: days) { newValue in
                    checkDays = ((Int(newValue) ?? 0) >= 1)
                }
                .bold()
                
                HStack{}.frame(height: 100)
                
                // to check the user's input, will only allow if the target amount of money will be bigger than the target of day(s), and will show a message of error
                if (Int(amount) ?? 0 < Int(days) ?? 0){
                    Text("Please set your target amount higher than your target day")
                        .padding(.horizontal, 50)
                        .multilineTextAlignment(.center)
                        .offset(y:-50)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                    
                }else{
                    // if the user's input already meet the requirement, the text of savings goal per day will be shown
                    Text("You need to save \nRp \(perDay) per day")
                        .multilineTextAlignment(.center)
                        .offset(y:-50)
                        .font(.system(size: 20, weight: .bold))
                        .opacity(perDay > 0 ? 1.0 : 0.0)
                }
                
                // to let the user to calculate their goal of savings per day
                Button("Calculate") {
                    let amountInt = Int(amount) ?? 0
                    let daysInt = Int(days) ?? 0
                    let result = Double(amountInt) / Double(daysInt)
                    perDay = Int(ceil(result))
                }
                .padding()
                
                .frame(width: geometry.size.width * 0.9)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .background(Color(hex: 0x6DA3FF))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 20, weight: .bold))
                .fontWeight(.bold)
                .disabled(!checkAmount || !checkDays) // the button will be disabled if the target amount and days are not meeting the requirement
            }
        }
        // allows view to extend content to entire screen
        .ignoresSafeArea(.all)
    }
    
    //func to display comma separator in textfield
    private func formatAmount(_ value: String) -> Binding<String> {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = ","
            formatter.usesGroupingSeparator = true

            let formattedValue = formatter.string(from: NSNumber(value: Int(value) ?? 0)) ?? ""

        return Binding<String>(
                    get: { "Rp " + (value.isEmpty ? "" : formattedValue) },
                    set: { newValue in
                        let cleanValue = newValue
                            .replacingOccurrences(of: "Rp ", with: "")
                            .replacingOccurrences(of: formatter.groupingSeparator, with: "")
                        amount = cleanValue
                    }
                )
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
    
    struct InputSavings_Previews: PreviewProvider {
        static var previews: some View {
            InputSavings()
        }
    }
}
