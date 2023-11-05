//
//  Event.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/4/23.
//

import Foundation


enum EventType: Codable{
    case social
    case career
    case health
    case love
    case family
}



//  前端的Event本身是没有功能的，承载数据
class Event: Codable {
    var id: Int
    var name: String
    var description: String
    var type: EventType
    var choices: [Choice]

    init(id: Int, name: String, description: String, type: EventType, choices: [Choice]) {
        self.id = id
        self.name = name
        self.description = description
        self.type = type
        self.choices = choices
    }

    func displaySummary() {
        print("Event \(id): \(name) - \(description)")
    }

    func handleChoice(_ choiceIndex: Int) {
        guard choiceIndex < choices.count else {
            print("Invalid choice index.")
            return
        }
        let selectedChoice = choices[choiceIndex]
        print("You have selected: \(selectedChoice.description)")

        // Further code to handle the choice...
    }

    func applyEffect() {
        // Code to apply the event's effects...
    }
}
