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
    
    // 这里可以定义主页需要的视图和数据模型
    var dataModel: HomePageDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 进行视图的初始化和数据绑定
    }
    
    // 主页的其他方法，比如处理用户的选择操作，跳转到功能页等
    
    // 用户按了Age Growth后如何向服务器request一个event。
    func ageCharacter(character: Character) {
        // Assuming there's an endpoint that gives us events based on character's current age.
        let url = URL(string: "服务器还没设置，我是一个假的URL!")
        
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
    
    func handleEventsForCharacter(character: Character, event: Event){
        //处理后续逻辑
    }
    func handleError(error:Error){
        //错误处理
    }

    
}


struct HomePageDataModel {
    // 主页的数据，比如列表项等
}


