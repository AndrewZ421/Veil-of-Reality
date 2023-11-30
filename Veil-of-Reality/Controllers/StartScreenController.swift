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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        newLifeBtn.addTarget(self, action: #selector(createNewLife), for: .touchUpInside)
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
        let firstName = "Test"
        let lastName = "son"
        let gender = "male"
        let nationality = "United States"
        let fatherFirstName = "Test"
        let fatherLastName = "dad"
        let motherFirstName = "Test"
        let motherLastName = "mom"
        dataModel = StartScreenDataModel(firstName: firstName, lastName: lastName, gender: gender, nationality: nationality, fatherFirstName: fatherFirstName, fatherLastName: fatherLastName, motherFirstName: motherFirstName, motherLastName: motherLastName)
        updateView()
        print("Start a new life!")
        
        let characterData = ["firstName": firstName, "lastName": lastName, "gender": gender, "nationality": nationality, "fatherFirstName": fatherFirstName, "fatherLastName": fatherLastName, "motherFirstName": motherFirstName, "motherLastName": motherLastName, "age": 0, "health": 50, "happiness": 50, "populrity": 50, "smarts": 50, "job": "Unempolyed", "salary": 0, "wealth": 0] as [String : Any]
        
        saveCharacterData(characterData: characterData)
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
