//
//  Group.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import Foundation

struct Group: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var description: String
    var teacherId: String?
    var studentIds: [String] = []
    
    var teacher: User? {
        guard let teacherId = self.teacherId else { return nil }

        let firstTeacherId = teacherId.split(separator: ",").map { String($0) }.first

        let teachersDictionary = Global.shared.users.reduce(into: [String: User]()) { dict, teacher in
            dict[teacher.id] = teacher
        }

        return firstTeacherId.flatMap { teachersDictionary[$0] }
    }
    
    var students: [User]? {

        let studentsDictionary = Global.shared.users.reduce(into: [String: User]()) { dict, student in
            dict[student.id] = student
        }

        return studentIds.compactMap { studentsDictionary[$0] }
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "name": name,
            "description": description,
            "studentIds": studentIds
        ]
        
        if let teacherId = teacherId {
            dictionary["teacherId"] = teacherId
        }
        
        return dictionary
    }
}
