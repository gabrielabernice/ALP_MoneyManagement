//
//  ContentView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            // to fill in the rest of the background color to fit our logo
            Color(UIColor(hex: "#75C1E1"))
                .edgesIgnoringSafeArea(.all)
            
            // our logo
            Image("launchImage") 
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        // to set the launch image to be shown for 2s
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isActive = true
            }
        }
        // to show the mainscreen after the launch screen
        .fullScreenCover(isPresented: $isActive, content: {
            MainScreen(savings: "S", history: [History(id: 0, category: "Shopping", amount: 30000, date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 7)) ?? Date(), type: "Expenses", name: "Expenses")])
        })
    }
}

// to make a customable color for the launch screen background
extension UIColor {
    convenience init(hex: String) {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        
        // Set collor rgb
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
