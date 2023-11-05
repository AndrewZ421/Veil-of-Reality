//
//  HomePageController.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation
import UIKit


// MARK: - 主页ViewController
class HomePageViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    let maincharacter = Character(id: 1, name: "Test man", age: 0, gender: Gender.male, occupation: Occupation.employed, married: false, student: false)
    
    
    
    // 这里可以定义主页需要的视图和数据模型
    var dataModel: HomePageDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 进行视图的初始化和数据绑定

    }
    
    // 这是连接到Storyboard中UIButton的IBAction
    @IBAction func didTapActionButton(_ sender: UIButton) {
        print("Button was tapped")
        var _ = ageCharacter(character:maincharacter)
        let testchoice = Choice(id: 1, description: "Test description")
        sendChoice(choice: testchoice)
    }
    
    // 主页的其他方法，比如处理用户的选择操作，跳转到功能页等
    func testConnection(){
        
    }
    
    // 用户按了Age Growth后如何向服务器request一个event。
    func ageCharacter(character: Character) {
        // Assuming there's an endpoint that gives us events based on character's current age.
        let url = URL(string: "http://127.0.0.1:5000")
        
        // The 'fetch' function is called with the expected type of `[Event].self`
        NetworkService.shared.fetch(url: url, expecting: Event.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    // Handle the successful retrieval of events
                    self.handleEventsForCharacter(character:character, event:events)
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


