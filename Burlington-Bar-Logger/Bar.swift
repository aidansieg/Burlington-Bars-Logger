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
    let barKey: String
    
    init (name: String, address: String, description: String, rating: Int) {
        self.name = name
        self.address = address
        self.description = description
        self.rating = rating
        self.barKey = UUID().uuidString
    }
    
    convenience init(random: Bool = false) {
        self.init(name: "", address: "", description: "", rating: 0)
    }
    
    static func ==(lhs: Bar, rhs: Bar) -> Bool {
        return lhs.name == rhs.name && lhs.address == rhs.address && lhs.rating == rhs.rating && lhs.description == rhs.description
    }
}

