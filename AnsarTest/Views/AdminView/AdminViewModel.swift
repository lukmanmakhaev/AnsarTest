//
//  AdminViewModel.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import Foundation
import FirebaseFirestore

final class AdminViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    func updateUser(user: User) {
        let userRef = db.collection("users").document(user.id)
        do {
                let userData = try Firestore.Encoder().encode(user)
                userRef.updateData(userData) { error in
                    if let error = error {
                        print("Error updating user: \(error.localizedDescription)")
                    } else {
                        print("User successfully updated")
                    }
                }
            } catch let error {
                print("Error encoding user: \(error.localizedDescription)")
            }
    }
    
    func  createGroup(group: Group) {
        db.collection("groups").document(group.id).setData(group.toDictionary()) { error in
            if let error = error {
                print("Error saving stop: \(error.localizedDescription)")
            } else {
                print("Stop saved successfully")
            }
        }
    }
}
