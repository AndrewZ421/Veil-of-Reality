//
//  Character.swift
//  Veil-of-Reality
//
//  Created by Liu Xin on 11/5/23.
//

import Foundation


enum Gender {
    case male, female, other
}

enum Occupation {
    case employed, unemployed, student
}


struct States {
    var ageGroup: Int
    var isMarried: Bool
    var occupation: Occupation
    var isStudent: Bool
    
    // This function calculates the group based on the state parameters.
    // Since ageGroup is already an Int, you might want to ensure that it's between 0 and 31 when it's set.
    func calculateGroup() -> Int {
        // Adjust the logic here to fit how you want the group to be determined.
        let ageBits = String(format: "%05d", Int(String(ageGroup, radix: 2)) ?? 0)
        let genderBit = isMarried ? "1" : "0"
        let marriedBit = occupation == .employed ? "1" : "0"
        let studentBit = isStudent ? "1" : "0"
        // 将所有的位字符串组合起来
        let combinedBits = ageBits + genderBit + marriedBit + studentBit
        
        // 将二进制字符串转换为十进制整数
        return Int(combinedBits, radix: 2) ?? 0
    }
}

class Character {
    var id: Int
    var name: String
    var age: Int
    var citizenship: String
    var gender: Gender
    var occupation: Occupation
    var states: States
    var group: Int
    var mather_name: String
    var father_name: String
    

    init(id: Int, name: String, age: Int, gender: Gender, occupation: Occupation, married: Bool, student: Bool, citizenship: String,mather: String, father: String) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.occupation = occupation
        // Calculate the age group based on the age provided. This is a simplification.
        let ageGroup = age / 3 // Assuming each stage represents 3 years for simplicity
        self.states = States(ageGroup: ageGroup, isMarried: married, occupation: occupation, isStudent: student)
        self.group = states.calculateGroup()
        self.citizenship = citizenship
        self.father_name = father
        self.mather_name = mather
    }
    
    // You can add other functions that utilize the information within the Character class.
    
    
}
