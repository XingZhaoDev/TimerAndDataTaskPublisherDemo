//
//  User.swift
//  TestingCombine-0429
//
//  Created by Xing Zhao on 2021/4/30.
//

import Foundation

struct User: Codable, Identifiable {
    
    struct Address: Codable {
        var street: String
        var suite: String
        var city: String
        var zipcode: String
    }
    
    struct Company: Codable {
        var name: String
        var catchPhrase: String
        var bs: String
    }
    
    struct Geo: Codable {
        var lat: String
        var lng: String
    }
    var id: Int
    var name: String
    var username: String
    var email: String?
    var address: Address?
    var geo: Geo?
    var company: Company?
    var phone: String?
    var website: String?
}
