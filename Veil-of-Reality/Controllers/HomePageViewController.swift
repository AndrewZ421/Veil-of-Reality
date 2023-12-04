//
//  HomePageController.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation
import UIKit
import SwiftUI


// MARK: - 主页ViewController
class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wealthLabel: UILabel!
    @IBOutlet weak var lifeTableView: UITableView!
    @IBOutlet weak var growBtn: UIButton!
    
    @IBOutlet weak var jobBtn: UIButton!
    @IBOutlet weak var wealthBtn: UIButton!
    
    @IBOutlet weak var healthBar: CircularProgressBarView!
    @IBOutlet weak var happinessBar: CircularProgressBarView!
    @IBOutlet weak var popularityBar: CircularProgressBarView!
    @IBOutlet weak var smartsBar: CircularProgressBarView!
    
    var lifeArray: Array<String> = [""]
    
    var mainCharacter = Character(id: 1, name: "Test man", age: 0, gender: Gender.male, occupation: Occupation.employed, married: false, student: false, citizenship: "United States", mother: "father man", father: "mother woman", health: 50, happiness: 50, popularity: 50, smarts: 50, job: "Unemployed", salary: 0, wealth: 0)
    
    var dataModel: HomePageDataModel!
    var occupationString: String!
    
//    struct CharacterDataModel: Codable {
//        var lastname: String
//        var gender: String
//        var fatherFirstName: String
//        var smarts: Int
//        var age: Int
//        var password: String
//        var fatherLastName: String
//        var nationality: String
//        var happiness: Int
//        var username: String
//        var health: Int
//        var job: String
//        var popularity: Int
//        var firstName: String
//        var salary: Int
//        var motherLastName: String
//        var wealth: Int
//        var motherFirstName: String
//    }
    var username: String!
    var password: String!
    var newLifeOrNot: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        refreshHomePageContent()
    }

    func refreshHomePageContent() {
        let characterData = loadCharacterData()
        print(characterData)
        let name = (characterData!["firstName"] as! String) + " " + (characterData!["lastName"] as! String)
        let age = characterData!["age"] as! Int
        let citizenship = characterData!["nationality"] as! String
        let father = (characterData!["fatherFirstName"] as! String) + " " + (characterData!["fatherLastName"] as! String)
        let mother = (characterData!["motherFirstName"] as! String) + " " + (characterData!["motherLastName"] as! String)
        let health = characterData!["health"] as! Int
        let happiness = characterData!["happiness"] as! Int
        let popularity = characterData!["popularity"] as! Int
        let smarts = characterData!["smarts"] as! Int
        let job = characterData!["job"] as! String
        let salary = characterData!["salary"] as! Int
        let wealth = characterData!["wealth"] as! Int
        
        mainCharacter = Character(id: 1, name: name, age: age, gender: .male, occupation: .unemployed, married: false, student: false, citizenship: citizenship, mother: mother, father: father, health: health, happiness: happiness, popularity: popularity, smarts: smarts, job: job, salary: salary, wealth: wealth)
        
        // Set nameLabel
        nameLabel.layer.borderWidth = 2.0
        nameLabel.layer.borderColor = UIColor.clear.cgColor
        nameLabel.layer.cornerRadius = 15.0
        nameLabel.layer.masksToBounds = true
        nameLabel.text = "  " + mainCharacter.name + ": " + mainCharacter.job
        
        // Set lifeTableView
        lifeTableView.dataSource = self
        lifeTableView.delegate = self
        lifeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        lifeTableView.separatorStyle = .none
        
        // Set healthBar
        healthBar.additionalText = "Health"
        healthBar.progress = CGFloat(mainCharacter.health) / 100
        
        // Set happinessBar
        happinessBar.additionalText = "Happiness"
        happinessBar.progress = CGFloat(mainCharacter.happiness) / 100
        
        // Set popularityBar
        popularityBar.additionalText = "Popularity"
        popularityBar.progress = CGFloat(mainCharacter.popularity) / 100
        
        // Set smartsBar
        smartsBar.additionalText = "Smarts"
        smartsBar.progress = CGFloat(mainCharacter.smarts) / 100
        
        // Set wealthLabel
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedWealth = numberFormatter.string(from: NSNumber(value: wealth)) ?? ""
        wealthLabel.text = "$" + formattedWealth
        
        // Set lifePath
        lifeArray = characterData!["path"] as! Array<String>
        print(lifeArray)
        


        
        lifeTableView.reloadData()
    }
    
    @IBAction func showJobView(_ sender: Any) {
        var jobView = JobView()
        jobView.onJobSelected = {
            self.refreshHomePageContent()
        }
        let hostingController = UIHostingController(rootView: jobView)
        self.present(hostingController, animated: true, completion: nil)
    }
    
    @IBAction func showWealthView(_ sender: Any) {
        var wealthView = WealthView()
        wealthView.onItemSelected = {
            self.refreshHomePageContent()
        }
        let hostingController = UIHostingController(rootView: wealthView)
        self.present(hostingController, animated: true, completion: nil)
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
        
//        var saveData: [String: Any] = [:]
//
//        var characterDataSave = characterData
//        characterDataSave["password"] = "1"
//        saveData["1"] = characterDataSave
//        print("#########saveData")
//        print(saveData)
//        print("#########")
//        let jsonData = try? JSONSerialization.data(withJSONObject: saveData)
////        let decodedData = try? JSONDecoder().decode(CharacterDataModel.self, from: saveData)
//        UserDefaults.standard.set(jsonData, forKey: "save")
        
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
    
    func doesCharacterDie(character: Character) -> Bool {
        let A = max(0.0005, 0.4 - (Double(character.health) / 100))
        let b = 0.1
        let c = 0.1
        
        let mortalityRate = A + (b * exp(c * Double(character.age)))
        
        let randomValue = Double(arc4random_uniform(1000)) / 1000.0

        return randomValue <= mortalityRate
    }
    
    func loadCharacterData() -> [String: Any]? {
        if(newLifeOrNot == true){
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
        }else{
            let storedData = UserDefaults.standard.data(forKey: "save")
            let decodedDictionary = try? JSONSerialization.jsonObject(with: storedData!, options: []) as? [String: Any]
            var characterInfo = decodedDictionary?[username] as? [String: Any]
//            characterInfo?["smarts"] = 10
            characterInfo?["password"] = nil
            return characterInfo
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        lifeTableView.deselectRow(at: indexPath, animated: true)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.textLabel!.text = lifeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
    }

    
    // 用户按了Age Growth后如何向服务器request一个event。
    @IBAction func ageCharacter() {
        // Assuming there's an endpoint that gives us events based on character's current age.
        
//        self.performSegue(withIdentifier: "ToEvent", sender: self)
        
//        let eventViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
//        self.navigationController?.pushViewController(eventViewController, animated: true)
//
        
        var characterData = loadCharacterData()
        let salary = characterData!["salary"] as! Int
        var age = characterData!["age"] as! Int
        var wealth = characterData!["wealth"] as! Int
        age = age + 1
        wealth = wealth + salary
        characterData!["wealth"] = wealth
        characterData!["age"] = age
        saveCharacterData(characterData: characterData!)
        if doesCharacterDie(character: mainCharacter) {
            let deathView = DeathView()
            let hostingController = UIHostingController(rootView: deathView)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

            self.navigationController?.pushViewController(hostingController, animated: true)
        }
        else
        {refreshHomePageContent()}
    }
    
    func sendChoice(choice: Choice){
        
        let url = URL(string: "http://127.0.0.1:5000")
        NetworkService.shared.pushData(to: url, data: choice){result in
            DispatchQueue.main.async {
                switch result{
                    case .success():
                        // The choice was successfully saved on the server
                        self.handleSuccessfulChoice()
                    case .failure(let error):
                        // Handle the error scenario
                    self.handleError(error: error)
                
                }
            }
        }
    }
    
    func handleEventsForCharacter(character: Character, event: Event){
        //处理后续逻辑
    }
    
    func handleSuccessfulChoice(){
        
    }
    
    func handleError(error:Error){
        //错误处理
    }
    
    func saveContent() {
        print("back to home")
    }

    
}


struct HomePageDataModel {
    // 主页的数据，比如列表项等
}


