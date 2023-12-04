//
//  JobView.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import SwiftUI

struct JobView: View {
    //弹窗相关属性
    @State private var showSuccuessAlert = false
    @State private var showAgeAlert = false
    @State private var showHealthAlert = false
    @State private var showHappinessAlert = false
    @State private var showPopularityAlert = false
    @State private var showSmartsAlert = false
    
    var onJobSelected: (() -> Void)?
    var username: String!
    var password: String!
    var newLifeOrNot: Bool!

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
            } .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RefreshData"))) { _ in
                // Refresh your data here
              
            }
            
            
            List(jobData) { job in
                Button(action: {
                    
                    var characterData: [String: Any] = [:]
                    if(newLifeOrNot == true){
                        characterData = loadCharacterData()!
                    }else{
                        let storedData = UserDefaults.standard.data(forKey: "save")
                        let decodedDictionary = try? JSONSerialization.jsonObject(with: storedData!, options: []) as? [String: Any]
                        var characterInfo = decodedDictionary?[username] as? [String: Any]
            //            characterInfo?["smarts"] = 10
                        characterInfo?["password"] = nil
                        characterData = characterInfo!
                    }
                    
                    
                    
                    
                    
                    
                    
                    print("\(job.name) was tapped")
                    
                    onJobSelected?()
                    //检查条件是否满足
                    if (characterData["age"] as! Int) < job.ageConstrain {
                        self.showAgeAlert = true
                    }
                    else if (characterData["health"] as! Int) < job.healthConstrain {
                        self.showHealthAlert = true
                    }
                    else if (characterData["happiness"] as! Int) < job.happinessConstrain {
                        self.showHappinessAlert = true
                    }
                    else if (characterData["popularity"] as! Int) < job.popularityConstrain {
                        self.showPopularityAlert = true
                    }
                    else if (characterData["smarts"] as! Int) < job.smartsConstrain {
                        self.showSmartsAlert = true
                    }
                    else {
                        //结果正确
                        self.showSuccuessAlert = true
                        characterData["job"] = job.name
                        characterData["salary"] = Int(job.salary.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))
                        saveCharacterData(characterData: characterData)
                        let storedData = UserDefaults.standard.data(forKey: "save")
                        var decodedDictionary: [String: Any] = [:]
                        if(storedData != nil ){
                            decodedDictionary = try! JSONSerialization.jsonObject(with: storedData!, options: []) as! [String : Any]
                        }
                        
                    //        let storedData = UserDefaults.standard.data(forKey: "save")
                    //        let decodedDictionary = try? JSONSerialization.jsonObject(with: storedData!, options: []) as? [String: Any]
                        print("#########storedData")
                        print(storedData)
                        print("#########")
                        print("#########decodedDictionary")
                        print(decodedDictionary)
                        print("#########")
                        
                        var saveData = decodedDictionary

                        var characterDataSave = characterData
                        print(username)
                        characterDataSave["password"] = password
                        saveData[username] = characterDataSave
                        print("#########")
                        print(saveData)
                        print("#########")
                        let jsonData = try? JSONSerialization.data(withJSONObject: saveData)
                    //        let decodedData = try? JSONDecoder().decode(CharacterDataModel.self, from: saveData)
                        UserDefaults.standard.set(jsonData, forKey: "save")
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
                
                .alert("Can't get this job", isPresented: $showAgeAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are too young!")
                }
                .alert("Can't get this job", isPresented: $showHealthAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are not healthy enough!")
                }
                .alert("Can't get this job", isPresented: $showHappinessAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are not mentally healthy enough!")
                }
                .alert("Can't get this job", isPresented: $showPopularityAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are not popular enough!")
                }
                .alert("Can't get this job", isPresented: $showSmartsAlert) {
                    Button("OK", role: .cancel){    }
                }message: {
                    Text("You are not smart enough!")
                }
                
                .alert("Change Job Successful", isPresented:$showSuccuessAlert ) {
                    Button("OK", role: .cancel) {   }
                } message: {
                    Text("You change your job successful!")
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
    let ageConstrain: Int
    let healthConstrain: Int
    let happinessConstrain: Int
    let popularityConstrain: Int
    let smartsConstrain: Int
}

let jobData = [
    JobData(imageName: "piano", name: "Pianist", salary: "$45,635", ageConstrain: 18, healthConstrain: 20, happinessConstrain: 10, popularityConstrain: 50, smartsConstrain: 50),
    JobData(imageName: "police", name: "Police", salary: "$41,000", ageConstrain: 22, healthConstrain: 70, happinessConstrain: 20, popularityConstrain: 20, smartsConstrain: 40),
    JobData(imageName: "director", name: "Director", salary: "$47,935", ageConstrain: 22, healthConstrain: 20, happinessConstrain: 20, popularityConstrain: 50, smartsConstrain: 40),
    JobData(imageName: "analyst", name: "Opertations Analyst", salary: "$62,190", ageConstrain: 22, healthConstrain: 30, happinessConstrain: 20, popularityConstrain: 20, smartsConstrain: 60),
    JobData(imageName: "bricklayer", name: "Bricklayer", salary: "$36,890", ageConstrain: 18, healthConstrain: 60, happinessConstrain: 10, popularityConstrain: 10, smartsConstrain: 10),
    JobData(imageName: "teacher", name: "Primary school Teacher", salary: "$50,165", ageConstrain: 22, healthConstrain: 40, happinessConstrain: 40, popularityConstrain: 30, smartsConstrain: 60),
    JobData(imageName: "taxidriver", name: "Taxi Driver", salary: "$38,480", ageConstrain: 22, healthConstrain: 40, happinessConstrain: 20, popularityConstrain: 30, smartsConstrain: 30)
    
    
]
