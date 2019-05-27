//
//  Person.swift
//  Ancestry
//
//  Created by Eric Lanza on 5/27/19.
//  Copyright © 2019 ETLanza. All rights reserved.
//

import UIKit

struct TopLevelPersonJSON: Decodable {
    let people: [Person]
    
    enum CodingKeys: String, CodingKey {
        case people = "Persons"
    }
}

class Person: Decodable {
    let name: String
    let portraitURL: URL
    let sex: String
    let birthInfo: BirthInfo
    let deathInfo: DeathInfo?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case portraitURL = "Portrait"
        case sex = "Sex"
        case birthInfo = "Birth"
        case deathInfo = "Death"
    }
    
    init(name: String, portraitURL: URL, sex: String, birthInfo: BirthInfo, deathInfo: DeathInfo) {
        self.name = name
        self.portraitURL = portraitURL
        self.sex = sex
        self.birthInfo = birthInfo
        self.deathInfo = deathInfo
    }
}

struct BirthInfo: Decodable {
    let date: String
    let name: String
    let lat: String
    let long: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case name = "Name"
        case lat = "Latitude"
        case long = "Longitude"
    }
}

struct DeathInfo: Decodable {
    let date: String
    let name: String
    let lat: String
    let long: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case name = "Name"
        case lat = "Latitude"
        case long = "Longitude"
    }
}
