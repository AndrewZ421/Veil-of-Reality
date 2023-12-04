//
//  EventViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/11/12.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    

    var choice: Choice!
    var event: Event!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let url = URL(string: "http://127.0.0.1:5000/get_event")
        print("Here")
        NetworkService.shared.fetch(url: url, expecting: Event.self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let event):  // 在这里添加 'let event'
                        // The event was successfully fetched from the server
                    self.getEvent(event: event)
                    case .failure(let error):
                        // Handle the error scenario
                        self.handleError(error: error)
                }
            }
        }



        
        
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func button1(_ sender: Any) {
//        choice.id = event.choices[0].id
//        choice.description = event.choices[0].description
//        sendChoice()
        jumpToHome()
    }
    @IBAction func button2(_ sender: Any) {
//        choice.id = event.choices[1].id
//        choice.description = event.choices[1].description
//        sendChoice()
        jumpToHome()
    }
    @IBAction func button3(_ sender: Any) {
//        choice.id = event.choices[2].id
//        choice.description = event.choices[2].description
//        sendChoice()
        jumpToHome()
    }
    @IBAction func button4(_ sender: Any) {
//        choice.id = event.choices[3].id
//        choice.description = event.choices[3].description
//        sendChoice()
        jumpToHome()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func sendChoice(){
        
        let url = URL(string: "http://127.0.0.1:5000")
        NetworkService.shared.pushData(to: url, data: self.choice){result in
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
    func jumpToHome(){
        let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.navigationController?.popViewController(animated: true)
    }
    func handleEventsForCharacter(character: Character, event: Event){
        //处理后续逻辑
    }
    
    func handleSuccessfulChoice(){
        
    }
    
    func handleError(error:Error){
        //错误处理
    }
    
    func getEvent(event: Event){
        eventName.text = event.name
        eventDescription.text = event.description
        choice1.setTitle(event.choices[0].description, for: .normal)
        choice2.setTitle(event.choices[1].description, for: .normal)
        choice3.setTitle(event.choices[2].description, for: .normal)
        choice4.setTitle(event.choices[3].description, for: .normal)
        var characterData = loadCharacterData()
        var lifePath = characterData!["path"] as! Array<String>
        var age = characterData!["age"] as! Int
        lifePath.append("")
        lifePath.append(String(age)+" years old")
        lifePath.append(event.description)
        characterData!["path"] = lifePath
        saveCharacterData(characterData: characterData!)
        print(event.self)
    }

}
