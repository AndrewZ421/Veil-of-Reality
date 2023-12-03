//
//  LogInViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/12/2.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logIn(_ sender: Any) {
        let storedData = UserDefaults.standard.data(forKey: "save")
        let decodedDictionary = try? JSONSerialization.jsonObject(with: storedData!, options: []) as? [String: Any]
        var characterInfo = decodedDictionary?[email.text ?? "dd"] as? [String: Any]
        if(characterInfo?["password"] as? String == password.text){
            jumpToContinueOrNewLife()
        }
        
    }
    func jumpToContinueOrNewLife(){
        let newLifeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewLifeViewController") as! NewLifeViewController
        newLifeViewController.username = email.text
        newLifeViewController.password = password.text
        newLifeViewController.newLifeOrNot = false
        print("newLifeViewController:\(newLifeViewController.username)")
        navigationController?.pushViewController(newLifeViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
