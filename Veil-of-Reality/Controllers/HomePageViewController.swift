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
    @IBOutlet weak var lifeTableView: UITableView!
    @IBOutlet weak var growBtn: UIButton!
    
    @IBOutlet weak var jobBtn: UIButton!
    @IBOutlet weak var wealthBtn: UIButton!
    
    @IBOutlet weak var healthBar: CircularProgressBarView!
    @IBOutlet weak var happinessBar: CircularProgressBarView!
    @IBOutlet weak var popularityBar: CircularProgressBarView!
    @IBOutlet weak var smartsBar: CircularProgressBarView!
    
    var lifeArray: Array<String> = ["0 years old", "Borned!", "", "1 years old", "Can walk", ""]
    
    var mainCharacter = Character(id: 1, name: "Test man", age: 0, gender: Gender.male, occupation: Occupation.employed, married: false, student: false, citizenship: "United States", mother: "father man", father: "mother woman", health: 50, happiness: 50, popularity: 50, smarts: 50, job: "Unemployed", salary: 0, wealth: 0)
    
    var dataModel: HomePageDataModel!
    var occupationString: String!
    
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
        
        //set avatar randomly
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
//        
        let url = URL(string: "http://127.0.0.1:5000")
        
//         The 'fetch' function is called with the expected type of `[Event].self`
        NetworkService.shared.fetch(url: url, expecting: Event.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    // Handle the successful retrieval of events
                    self.handleEventsForCharacter(character: self.mainCharacter, event: events)
                case .failure(let error):
                    // Handle the error scenario
                    self.handleError(error:error)
                }
            }
        }
        
        var characterData = loadCharacterData()
        let salary = characterData!["salary"] as! Int
        var wealth = characterData!["wealth"] as! Int
        wealth = wealth + salary
        characterData!["wealth"] = wealth
        saveCharacterData(characterData: characterData!)
        print(characterData)
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

    
}


struct HomePageDataModel {
    // 主页的数据，比如列表项等
}


