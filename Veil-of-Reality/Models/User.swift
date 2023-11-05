//
//  User.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation


class User {
    var username: String
    var password: String
    var characters: [Character]

    init(username: String, password: String, characters: [Character] = []) {
        self.username = username
        self.password = password
        self.characters = characters
    }

    // Add a new character to the user's list
    func addCharacter(_ character: Character) {
        characters.append(character)
    }

    // Remove a character from the user's list by name
    func removeCharacterByName(_ name: String) {
        characters.removeAll { $0.name == name }
    }

    // You might want to include other functionalities, such as authentication methods, etc.
}

//// Example usage:
//let user = User(username: "exampleUser", password: "securePassword123")
//let character1 = Character(name: "Alice", age: 25, gender: .female, occupation: .employed, married: false, student: false)
//let character2 = Character(name: "Bob", age: 30, gender: .male, occupation: .unemployed, married: true, student: false)
//
//// Add characters to the user
//user.addCharacter(character1)
//user.addCharacter(character2)
//
//// Remove a character
//user.removeCharacterByName("Alice")
