//
//  HomePageController.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation
import UIKit


// MARK: - 主页ViewController
class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lifeTableView: UITableView!
    @IBOutlet weak var growBtn: UIButton!
    @IBOutlet weak var healthBar: CircularProgressBarView!
    @IBOutlet weak var happinessBar: CircularProgressBarView!
    @IBOutlet weak var populrityBar: CircularProgressBarView!
    @IBOutlet weak var smartsBar: CircularProgressBarView!
    
    var character = Character(id: 1, name: "test son", age: 2, gender: .male, occupation: .unemployed, married: false, student: false, citizenship: "US", mother: "test mom", father: "test dad")
    var lifeArray: Array<String> = ["0 years old", "Borned!", "", "1 years old", "Can walk", ""]
    
    let maincharacter = Character(id: 1, name: "Test man", age: 0, gender: Gender.male, occupation: Occupation.employed, married: false, student: false, citizenship: "United States", mother: "father man", father: "mother woman")
    
    var dataModel: HomePageDataModel!
    var occupationString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        var characterData = loadCharacterData()
        print(characterData)

        // Set nameLabel
        switch maincharacter.occupation {
        case .employed:
            occupationString = "Employed"
        case .unemployed:
            occupationString = "Unemployed"
        case .student:
            occupationString = "Student"
        }
        nameLabel.layer.borderWidth = 2.0
        nameLabel.layer.borderColor = UIColor.clear.cgColor
        nameLabel.layer.cornerRadius = 15.0
        nameLabel.layer.masksToBounds = true
        nameLabel.text = "  " + maincharacter.name + ": " + occupationString
        
        // Set lifeTableView
        lifeTableView.dataSource = self
        lifeTableView.delegate = self
        lifeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        lifeTableView.separatorStyle = .none
        
        // Set healthBar
       
        healthBar.additionalText = "Health"
        healthBar.progress = 0.6
        
        // Set happinessBar
        
        happinessBar.additionalText = "Happiness"
        happinessBar.progress = 0.3
        
        // Set populrityBar
       
        populrityBar.additionalText = "Populrity"
        populrityBar.progress = 0.2
        
        // Set smartsBar
        
        smartsBar.additionalText = "Smarts"
        smartsBar.progress = 0.8
        
        //set avatar randomly
        
        
    }
    
    func saveCharacterData(characterData: [String: Any]) {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("characterData.json")
            print(fileURL)
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: characterData, options: .prettyPrinted)
                    try jsonData.write(to: fileURL)
                } catch {
                    print("Error saving characterData.json: \(error)")
                }
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: characterData, options: .prettyPrinted)
                    fileManager.createFile(atPath: fileURL.path, contents: jsonData, attributes: nil)
                } catch {
                    print("Error creating characterData.json: \(error)")
                }
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
                    self.handleEventsForCharacter(character:self.character, event:events)
                case .failure(let error):
                    // Handle the error scenario
                    self.handleError(error:error)
                }
            }
        }
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


