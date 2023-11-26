//
//  WealthView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import SwiftUI

struct WealthView: View {
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
            .padding(.top, 5.0);
            
            List(wealthData) { item in
                Button(action: {
                    //点击后的行为
                    
                    print("\(item.name) was tapped")
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
                    
                    
                }
                
            }
            .padding(.bottom, 1.0)
            Image("moneywings")
            
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
}

let wealthData = [
    WealthData(imageName: "movie", name: "Make a movie", cost: "-$65,195"),
    WealthData(imageName: "haircut", name: "Haircut", cost: "-$50"),
    WealthData(imageName: "church", name: "Donate to the church", cost: "-$1000"),
    WealthData(imageName: "shopping", name: "Shopping", cost: "-$2190"),
    WealthData(imageName: "master", name: "Attend graduate school", cost: "-$57,600"),
    WealthData(imageName: "gym", name: "Go Gym", cost: "-$216"),
    WealthData(imageName: "cigarette", name: "Buy Cigarette", cost: "-$125")
    
]
