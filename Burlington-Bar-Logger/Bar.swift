//
//  Bar.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 10/17/21.
//

import UIKit

class Bar: Equatable, Codable{
    var name: String
    var address: String
    var description: String
    var rating: Int
    // add photo property
    
    init (name: String, address: String, description: String, rating: Int) {
        self.name = name
        self.address = address
        self.description = description
        self.rating = rating
    }
    
//    convenience init(random: Bool = false) {
//        if random {
//            let adjectives = ["fluffy", "rusty", "shiny"]
//            let nouns = ["dog", "cat", "mouse"]
//
//            let randomAdj = adjectives.randomElement()!
//            let randomNoun = nouns.randomElement()!
//
//            let randomName = "\(randomAdj) \(randomNoun)"
//            let randomRate = Int.random(in: 0..<100)
//            let randomAddress = UUID().uuidString.components(separatedBy: "-").first!
//
//            self.init(name: randomName, address: randomAddress, description: randomAddress, rating: randomRate)
//
//        } else {
//            self.init(name: "", address: "", description: "", rating: 0)
//        }
//    }
    
    convenience init(random: Bool = false) {
        self.init(name: "", address: "", description: "", rating: 0)
    }
    
    static func ==(lhs: Bar, rhs: Bar) -> Bool {
        return lhs.name == rhs.name && lhs.address == rhs.address && lhs.rating == rhs.rating && lhs.description == rhs.description
    }
}

