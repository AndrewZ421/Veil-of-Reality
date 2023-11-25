//
//  DeathView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/23/23.
//

import SwiftUI

struct DeathView: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 374, height: 798)
                .background(Color(red: 1, green: 0.93, blue: 0.9))
            
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 6.5)
                        .stroke(.white.opacity(0.88), lineWidth: 13)
                    
                )
            
            VStack {
                Image("coffin").frame(width: 80, height: 80).padding()
                
                Image("gameover").frame(width: 300, height: 52).padding()
               
                ZStack {
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 300, height: 227)
                    .background(Color(red: 0.29, green: 0.29, blue: 0.38))

                    .cornerRadius(20)
                .padding()
                    
                    Text("You died \nat the age of 18!")
                    .font(Font.custom("JotiOne-Regular", size: 32))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    
                    .multilineTextAlignment(.center)
                    
                }
                
                Image("startbutton").frame(width: 140, height: 88).padding()
            }
            
            
        }
        
        
    }
}

struct DeathView_Previews: PreviewProvider {
    static var previews: some View {
        DeathView()
    }
}
