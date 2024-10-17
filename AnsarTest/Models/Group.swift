//
//  Group.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import Foundation

struct Group: Identifiable, Codable {
    let id: String
    let name: String
    let students: [User]
    let teacher: [User]
}
