//
//  JobView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import SwiftUI

struct JobView: View {
    //弹窗相关属性
    @State private var showAlert = false
    @State private var isConditionMet = false
    
    var onJobSelected: (() -> Void)?
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
                    .padding(.top,40)
                
                Text("Occupation").font(Font.custom("JotiOne-Regular", size: 32))
                    .foregroundColor(.white)
                    .padding(.top, 40)
            }
            
            
            List(jobData) { job in
                Button(action: {
                    var characterData = loadCharacterData()
                    characterData!["job"] = job.name
                    characterData!["salary"] = Int(job.salary.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))
                    saveCharacterData(characterData: characterData!)
                    print("\(job.name) was tapped")
                    
                    onJobSelected?()
                    //检查条件是否满足
                    if !isConditionMet {
                        self.showAlert = true
                    }
                    
                })
                {
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
                .padding(.bottom,-3)
                
                .alert("Can't get a job", isPresented: $showAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are not smart enough!")
                }
                        
                    
                    
                    
                
                
            }
            
            
            Image("jobsentence")
            
        }
        
            
            
           
            
        }
        
        
        
        
        
    }
    

func saveCharacterData(characterData: [String: Any]) {
    let fileManager = FileManager.default
        
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("characterData.json")
        
        print(fileURL)
        
        // Delete old file if exists
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
                print("Deleted existing characterData.json")
            } catch {
                print("Error deleting existing characterData.json: \(error)")
            }
        }
        
        // Create a new json file
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: characterData, options: [])
            try jsonData.write(to: fileURL)
            print("Saved characterData.json")
        } catch {
            print("Error saving characterData.json: \(error)")
        }
    }
}

func loadCharacterData() -> [String: Any]? {
    let fileManager = FileManager.default
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("characterData.json")
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let characterData = jsonObject as? [String: Any] {
                    return characterData
                }
            } catch {
                print("Error loading characterData.json: \(error)")
            }
        }
    }
    
    return nil
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
