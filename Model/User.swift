//
//  User.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var company: Company
    var address: Address
}

struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
}

struct Address: Codable {
    var street: String
    var city: String
    var zipcode: String
    var suite: String

}

struct Geo: Codable {
    var lat: Double
    var lng: Double
}
