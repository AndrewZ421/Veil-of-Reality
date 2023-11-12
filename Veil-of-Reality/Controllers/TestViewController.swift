//
//  TestViewController.swift
//  Veil-of-Reality
//
//  Created by 曲奕 on 2023/11/12.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true

    }
    @IBAction func but(_ sender: Any) {
        jumpToHome()
    }
    func jumpToHome(){
        let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.navigationController?.pushViewController(homePageViewController, animated: true)
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
