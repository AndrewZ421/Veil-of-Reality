//
//  WealthView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import SwiftUI

struct WealthView: View {
    @State private var showSuccuessAlert = false
    @State private var showAlert = false
    
    var onItemSelected: (() -> Void)?
    var body: some View {
        VStack {
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 374.0, height: 70)
                    .background(Color(red: 0.18, green: 0.49, blue: 0.20))
                    .overlay(
                        Rectangle()
                            .inset(by: 0.50)
                            .stroke(Color(red: 0.64, green: 0.65, blue: 0.65), lineWidth: 0.50)
                    )
                    
                
                Text("Wealth").font(Font.custom("JotiOne-Regular", size: 32))
                    .foregroundColor(.white)
            }
            .padding(.top, 40);
            
            List(wealthData) { item in
                Button(action: {
                    print("\(item.name) was tapped")
                    let cost = Int(item.cost.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))!
                    let characterData = loadCharacterData()
                    let health = characterData!["health"] as! Int
                    let happiness = characterData!["happiness"] as! Int
                    let popularity = characterData!["popularity"] as! Int
                    let smarts = characterData!["smarts"] as! Int
                    let wealth = characterData!["wealth"] as! Int

                    if wealth >= cost {
                        self.showSuccuessAlert = true
                        var updatedCharacterData = characterData // Create a mutable copy

                        // Update the values
                        updatedCharacterData!["wealth"] = wealth - cost
                        updatedCharacterData!["health"] = min(100, max(health + item.changes[0], 0))
                        updatedCharacterData!["happiness"] = min(100, max(happiness + item.changes[1], 0))
                        updatedCharacterData!["popularity"] = min(100, max(popularity + item.changes[2], 0))
                        updatedCharacterData!["smarts"] = min(100, max(smarts + item.changes[3], 0))

                        // Save the updated character data
                        saveCharacterData(characterData: updatedCharacterData!)
                    }
                    else {
                        self.showAlert = true
                    }
                    onItemSelected?()
                }){
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack {
                            Text(item.name).font(.system(size: 23))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(item.cost).font(.system(size: 15))
                                .foregroundColor(Color(red: 0.16, green: 0.35, blue: 0.51))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    .padding(.bottom, -4)
                    .alert("Failed Purchase", isPresented: $showAlert) {
                        Button("OK", role: .cancel){    }
                    }message: {
                        Text("You don't have enough money!")
                    }
                    .alert("Successful Purchase",isPresented: $showSuccuessAlert) {
                        Button("OK", role: .cancel){    }
                    }message: {
                        Text("Purchase Successfully")
                    }
                }
                
            }
            
           
            Image("moneywings").padding(.top,-10)
            
        }
            
            
            
           
            
        
        
    }
}

struct WealthView_Previews: PreviewProvider {
    static var previews: some View {
        WealthView()
    }
}


struct WealthData: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let cost: String
    let changes: [Int]
}

let wealthData = [
    WealthData(imageName: "movie", name: "Make a movie", cost: "$65,195", changes: [0, 5, 0, 0]),
    WealthData(imageName: "haircut", name: "Haircut", cost: "$50", changes: [0, 1, 1, 0]),
    WealthData(imageName: "church", name: "Donate to the church", cost: "$1000", changes: [0, 2, 0, 0]),
    WealthData(imageName: "shopping", name: "Shopping", cost: "$2190", changes: [0, 3, 0, 0]),
    WealthData(imageName: "master", name: "Attend graduate school", cost: "$57,600", changes: [0, 0, 0, 10]),
    WealthData(imageName: "gym", name: "Go Gym", cost: "$216", changes: [1, 0, 1, 0]),
    WealthData(imageName: "cigarette", name: "Buy Cigarette", cost: "$125", changes: [-1, 2, 0, 0])
    
]
