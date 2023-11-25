//
//  OccupationViewController.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import UIKit

class OccupationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //存储信息（cell)
    var listInfo : [ListInfo] = [
        ListInfo(name: "Pianist", money: "$45,675")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
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


//MARK: - UITableViewDataSource

extension OccupationViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ListCell
        cell.nameLabel.text = listInfo[indexPath.row].name
        return cell
    }
    
    
}
