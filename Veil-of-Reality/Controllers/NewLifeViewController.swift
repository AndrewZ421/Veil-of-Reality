//
//  NewLifeViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/12/2.
//

import UIKit

class NewLifeViewController: UIViewController {
    

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var newLife: UIButton!
    var username: String!
    var password: String!
    var newLifeOrNot: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
//        continueBtn.backgroundColor = UIColor.black
//        newLife.backgroundColor = UIColor.black
    }
    
    @IBAction func continueLife(_ sender: Any) {
        jumpToHome()
    }
    @IBAction func startNewLife(_ sender: Any) {
        jumpToStart()
        
    }
    func jumpToHome(){
        let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        homePageViewController.username = username
        homePageViewController.password = password
        homePageViewController.newLifeOrNot = newLifeOrNot
        print("username:\(username)")
        navigationController?.pushViewController(homePageViewController, animated: true)
        print("continue pressed")
        
//        navigationController?.pushViewController(homePageViewController, animated: true)
    }
    func jumpToStart(){
        let startScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartScreenViewController") as! StartScreenController
        startScreenViewController.username = username
        startScreenViewController.password = password
        startScreenViewController.newLifeOrNot = true
        navigationController?.pushViewController(startScreenViewController, animated: true)
        print("New life pressed")
        
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
