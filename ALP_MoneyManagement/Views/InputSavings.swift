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
                        

                    
                    VStack(alignment:.leading, spacing: -5) {
                        Text("Savings Target")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        TextField("Rp", text: $amount)
                            .padding()
                            .font(.system(size: 16, weight: .bold))
                            .background(Color(.white))
                            .cornerRadius(10)
                            .frame(width: 350, height: 90)
                            .keyboardType(.numberPad)
                        
                        Text("*Only numbers above 0")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .opacity(!checkAmount ? 1 : 0)
                    }
                    
                    VStack(alignment:.leading, spacing: -5) {
                        Text("Target Day")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        TextField("Day", text: $days)
                            .padding()
                            .font(.system(size: 16, weight: .bold))
                            .background(Color(.white))
                            .cornerRadius(10)
                            .frame(width: 350, height: 90)
                        
                            .keyboardType(.numberPad)
                        
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
                .background(Color(hex: 0x6DA3FF))
                .clipShape(BottomRoundedRectangle(radius:55))
                .shadow(color: Color.black.opacity(0.3), radius: 18, x: 0, y: 5)
                .onChange(of: amount) { newValue in
                            checkAmount = ((Int(newValue) ?? 0) >= 1)
                        }
                        .onChange(of: days) { newValue in
                            checkDays = ((Int(newValue) ?? 0) >= 1)
                        }
                        .bold()
                
                HStack{}.frame(height: 150)
                
                if (Int(amount) ?? 0 < Int(days) ?? 0){
                    Text("Please set your target amount higher than your target day")
                        .padding(.horizontal, 50)
                        .multilineTextAlignment(.center)
                        .offset(y:-80)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                    
                }else{
                    Text("You need to save \nRp. \(perDay) per day")
                        .multilineTextAlignment(.center)
                        .offset(y:-80)
                        .font(.system(size: 20, weight: .bold))
                        .opacity(perDay > 0 ? 1.0 : 0.0)
                }
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
                .disabled(!checkAmount || !checkDays)
                            
                       
                
                
            }
            
            
        }
        .ignoresSafeArea(.all)
        
    }
    
    struct InputSavings_Previews: PreviewProvider {
        static var previews: some View {
            InputSavings()
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
}
