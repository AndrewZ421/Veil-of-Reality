//
//  StartScreenController.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation
import UIKit


// MARK: - StartScreenController
class StartScreenController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var fatherNameLabel: UILabel!
    @IBOutlet weak var motherNameLabel: UILabel!
    @IBOutlet weak var newLifeBtn: UIButton!
    
    var dataModel: StartScreenDataModel!
    
    var username: String!
    var password: String!
    var newLifeOrNot: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
//        newLifeBtn.addTarget(self, action: #selector(createNewLife), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createNewLife()
        
        // Set fullNameLabel
        fullNameLabel.layer.borderWidth = 2.0
        fullNameLabel.layer.borderColor = UIColor.clear.cgColor
        fullNameLabel.layer.cornerRadius = 15.0
        fullNameLabel.layer.masksToBounds = true
        
        // Set genderLabel
        genderLabel.layer.borderWidth = 2.0
        genderLabel.layer.borderColor = UIColor.clear.cgColor
        genderLabel.layer.cornerRadius = 15.0
        genderLabel.layer.masksToBounds = true
        
        // Set nationalityLabel
        nationalityLabel.layer.borderWidth = 2.0
        nationalityLabel.layer.borderColor = UIColor.clear.cgColor
        nationalityLabel.layer.cornerRadius = 15.0
        nationalityLabel.layer.masksToBounds = true
        
        // Set fatherNameLabel
        fatherNameLabel.layer.borderWidth = 2.0
        fatherNameLabel.layer.borderColor = UIColor.clear.cgColor
        fatherNameLabel.layer.cornerRadius = 15.0
        fatherNameLabel.layer.masksToBounds = true
        
        // Set motherNameLabel
        motherNameLabel.layer.borderWidth = 2.0
        motherNameLabel.layer.borderColor = UIColor.clear.cgColor
        motherNameLabel.layer.cornerRadius = 15.0
        motherNameLabel.layer.masksToBounds = true
        
        // Set first horizontal line
        let rect1 = CGRect(x: 40, y: fullNameLabel.frame.origin.y + 80, width: self.view.viewWidth - 80, height: 1)
        let lineView1 = UIView(frame: rect1)
        lineView1.backgroundColor = .white
        self.view.addSubview(lineView1)
        
        // Set second horizontal line
        let rect2 = CGRect(x: 40, y: motherNameLabel.frame.origin.y + 80, width: self.view.viewWidth - 80, height: 1)
        let lineView2 = UIView(frame: rect2)
        lineView2.backgroundColor = .white
        self.view.addSubview(lineView2)

    }

    
    func updateView(){
        // Set fullNameLabel
        fullNameLabel.text = dataModel.firstName + " "  + dataModel.lastName + " Born!"
        
        // Set genderLabel
        if (dataModel.gender == "male") {
            genderLabel.text = "👦🏻 Male "
            // Add one more space at the end of the string makes it look more centered
        } else {
            genderLabel.text = "👧🏼 Female "
        }
        
        // Set nationalityLabel
        // TODO: Need to update the flag accroding to the dataModel.nationality
        nationalityLabel.text = "🇺🇸 United States"
//        nationalityLabel.text = dataModel.nationality
        nationalityLabel.layer.borderWidth = 2.0
        nationalityLabel.layer.borderColor = UIColor.clear.cgColor
        nationalityLabel.layer.cornerRadius = 15.0
        nationalityLabel.layer.masksToBounds = true
        
        // Set fatherNameLabel
        fatherNameLabel.text = "Father: " + dataModel.fatherFirstName + " "  + dataModel.fatherLastName
        
        // Set motherNameLabel
        motherNameLabel.text = "Mother: " + dataModel.motherFirstName + " "  + dataModel.motherLastName
    }
    
    @IBAction func createNewLife() {
        var firstName = "Test"
        var lastName = "son"
        var gender = "male"
        var nationality = "United States"
        var fatherFirstName = "Test"
        var fatherLastName = "dad"
        var motherFirstName = "Test"
        var motherLastName = "mom"

        print("Start a new life!")
        
        let url = URL(string: "http://127.0.0.1:5000/create_character")
        
        NetworkService.shared.fetch(url: url, expecting: Character.self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let character):  // 在这里添加 'let event'
                        // The event was successfully fetched from the server
                    var sonName = character.name.split(separator: " ")
                    firstName = String(sonName[0])
                    lastName = ""
                    gender = character.gender.rawValue
                    
                    
                    nationality = character.citizenship
                    fatherFirstName = character.fatherName
                    fatherLastName = ""
                    motherFirstName = character.motherName
                    motherLastName = ""
                    self.dataModel = StartScreenDataModel(firstName: firstName, lastName: lastName, gender: gender, nationality: nationality, fatherFirstName: fatherFirstName, fatherLastName: fatherLastName, motherFirstName: motherFirstName, motherLastName: motherLastName)
                    let characterData = ["firstName": firstName, "lastName": lastName, "gender": gender, "nationality": nationality, "fatherFirstName": fatherFirstName, "fatherLastName": fatherLastName, "motherFirstName": motherFirstName, "motherLastName": motherLastName, "age": 0, "health": Int(arc4random_uniform(91)) + 10, "happiness": Int(arc4random_uniform(91)) + 10, "popularity": Int(arc4random_uniform(91)) + 10, "smarts": Int(arc4random_uniform(91)) + 10, "job": "Unempolyed", "salary": 0, "wealth": Int(arc4random_uniform(91)) + 10, "path": ["0 years old", "Borned!",""]] as [String : Any]
                    print("We here")
                    print(fatherFirstName)
                    self.saveCharacterData(characterData: characterData)

                    self.updateView()
                    case .failure(_):
                        // Handle the error scenario
                    print("Error")
                        
                }
            }
        }
        dataModel = StartScreenDataModel(firstName: firstName, lastName: lastName, gender: gender, nationality: nationality, fatherFirstName: fatherFirstName, fatherLastName: fatherLastName, motherFirstName: motherFirstName, motherLastName: motherLastName)

        print(dataModel)

        
        updateView()
        
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
    
    @IBAction func start(_ sender: Any) {
        let homePageViewController = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        homePageViewController.username = username
        homePageViewController.password = password
        homePageViewController.newLifeOrNot = newLifeOrNot
        navigationController?.pushViewController(homePageViewController, animated: true)
    }
    
}

struct StartScreenDataModel {
    var firstName: String
    var lastName: String
    var gender: String
    var nationality: String
    var fatherFirstName: String
    var fatherLastName: String
    var motherFirstName: String
    var motherLastName: String
}

extension UIView {
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }

    public var viewHeight: CGFloat {
        return self.frame.size.height
    }
}
