//
//  User.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import Foundation

enum UserType: String {
    case student
    case teacher
    case parent
    case director
}

class User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    var isAdmin: Bool = false
    var userType: String
    
    init(id: String, name: String, email: String, isAdmin: Bool, userType: String) {
        self.id = id
        self.name = name
        self.email = email
        self.isAdmin = isAdmin
        self.userType = userType
    }
}
