//
//  ContentView.swift
//  ALP_MoneyManagement
//
//  Created by MacBook Pro on 03/05/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome Aboard!")
                    .foregroundColor(Color(red: 84/255, green: 84/255, blue: 84/255))
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                Spacer()
                
                Image(systemName: "dollarsign.circle.fill") // logo?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.green) // biar jamet
                
                Spacer()
                
                Text("Are you ready\nto manage your money?") // ato apa itu slogan e
                    .font(.headline)
                    .foregroundColor(Color(red: 84/255, green: 84/255, blue: 84/255))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                NavigationLink(destination: MainScreen(savings: "")){
                    Text("START")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.6, blue: 1.0)) // kalo mau biru
                        .background(.green) // kalo mau hijau
                        .cornerRadius(10)
                }
            }
        }
        .bold()
    }
}


struct ContentView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
