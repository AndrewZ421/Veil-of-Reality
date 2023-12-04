import Foundation

enum Gender: String, Decodable {
    case male = "male"
    case female = "female"
    case other = "other"
}

enum Occupation: String, Decodable {
    case employed = "employed"
    case unemployed = "unemployed"
    case student = "student"
}

struct States: Decodable {
    var ageGroup: Int
    var isMarried: Bool
    var occupation: Occupation
    var isStudent: Bool
    
    func calculateGroup() -> Int {
        let ageBits = String(format: "%05d", Int(String(ageGroup, radix: 2)) ?? 0)
        let genderBit = isMarried ? "1" : "0"
        let marriedBit = occupation == .employed ? "1" : "0"
        let studentBit = isStudent ? "1" : "0"
        let combinedBits = ageBits + genderBit + marriedBit + studentBit
        return Int(combinedBits, radix: 2) ?? 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case ageGroup, isMarried, occupation, isStudent
    }
}

class Character: Decodable {
    var id: Int
    var name: String
    var age: Int
    var citizenship: String
    var gender: Gender
    var occupation: Occupation
    var motherName: String
    var fatherName: String
    var health: Int
    var happiness: Int
    var popularity: Int
    var smarts: Int
    var job: String
    var salary: Int
    var wealth: Int
    
    init(id: Int, name: String, age: Int, gender: Gender, occupation: Occupation, married: Bool, student: Bool, citizenship: String, mother: String, father: String, health: Int, happiness: Int, popularity: Int, smarts: Int, job: String, salary: Int, wealth: Int) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.occupation = occupation
        let ageGroup = age / 3
        self.citizenship = citizenship
        self.motherName = mother
        self.fatherName = father
        self.health = health
        self.happiness = happiness
        self.popularity = popularity
        self.smarts = smarts
        self.job = job
        self.salary = salary
        self.wealth = wealth
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, age, citizenship, gender, occupation, motherName = "mother_name", fatherName = "father_name", health, happiness, popularity, smarts, job, salary, wealth
    }
}
