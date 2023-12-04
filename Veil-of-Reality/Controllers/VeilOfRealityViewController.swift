//
//  VeilOfRealityViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/12/2.
//

import UIKit

class VeilOfRealityViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        
//        UserDefaults.standard.removeObject(forKey: "save")
//        if let retrievedValue = UserDefaults.standard.data(forKey: "save"),
//           let decodedDictionary = try? JSONSerialization.jsonObject(with: retrievedValue, options: []) as? [String: Any]{
//            print("Retrieved Value: \(decodedDictionary)")
//        } else {
//            print("No value found for key 'myKey'")
//        }
        
        
        
        
        
        
        jumpToRegister()
    }
    @IBAction func logIn(_ sender: Any) {
        jumpToLogIn()
    }
    
    func jumpToRegister(){
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(registerViewController, animated: true)
        
//        navigationController?.pushViewController(homePageViewController, animated: true)
    }
    func jumpToLogIn(){
        let logInViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        navigationController?.pushViewController(logInViewController, animated: true)
        
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
