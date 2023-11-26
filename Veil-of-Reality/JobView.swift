//
//  JobView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import SwiftUI

struct JobView: View {
    
    var body: some View {
        
        
        
        VStack {
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 374.0, height: 70)
                    .background(Color(red: 0.42, green: 0.58, blue: 0.70))
                    .overlay(
                        Rectangle()
                            .inset(by: 0.50)
                            .stroke(Color(red: 0.64, green: 0.65, blue: 0.65), lineWidth: 0.50)
                    )
                
                Text("Occupation").font(Font.custom("JotiOne-Regular", size: 32))
                    .foregroundColor(.white)
            }
            .padding(.top);
            
            List(jobData) { job in
                Button(action: {
                    //点击后的行为
                    
                    print("\(job.name) was tapped")
                }){
                    HStack {
                        Image(job.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack {
                            Text(job.name).font(.system(size: 23))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(job.salary).font(.system(size: 15))
                                .foregroundColor(Color(red: 0.16, green: 0.35, blue: 0.51))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    
                    
                }
                
            }
            .padding(.bottom, 2.0)
            Image("jobsentence")
            
        }
            
            
            
           
            
        }
        
        
        
        
        
    }
    
    


struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}

struct JobData: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let salary: String
}

let jobData = [
    JobData(imageName: "piano", name: "Pianist", salary: "$45,635"),
    JobData(imageName: "police", name: "Police", salary: "$41,000"),
    JobData(imageName: "director", name: "Director", salary: "$47,935"),
    JobData(imageName: "analyst", name: "Opertations Analyst", salary: "$62,190"),
    JobData(imageName: "bricklayer", name: "Bricklayer", salary: "$36,890"),
    JobData(imageName: "teacher", name: "Primary school Teacher", salary: "$50,165"),
    JobData(imageName: "taxidriver", name: "Taxi Driver", salary: "$38,480")
    
    
]
