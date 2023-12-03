//
//  RegisterViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/12/2.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    @IBAction func register(_ sender: Any) {
        
        jumpToStart()
    }
    func jumpToStart(){
        let startScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartScreenViewController") as! StartScreenController
        startScreenViewController.username = email.text
        startScreenViewController.password = password.text
        startScreenViewController.newLifeOrNot = true
        navigationController?.pushViewController(startScreenViewController, animated: true)
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
