//
//  User.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import Foundation

enum UserType: String, CaseIterable, Codable {
    case student = "student"
    case teacher = "teacher"
    case admin = "admin"
}

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    var bio: String?
    var groupIds: [String]?
    var userType: UserType
}
