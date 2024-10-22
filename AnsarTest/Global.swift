//
//  Global.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 21.10.2024.
//

import Foundation
import FirebaseFirestore


final class Global: ObservableObject {
    static let shared = Global()
    
    @Published var users: [User] = []
    @Published var groups: [Group] = []
    
    private let db = Firestore.firestore()
    
    init () {
        Task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() {
        Task {
            do {
                users = try await fetchUsers()
                groups = try await fetchGroups()
            } catch {
                print("Error fetching buses: \(error)")
            }
        }
    }
    
    func fetchGroups() async throws -> [Group] {
        let snapshot = try await db.collection("groups").getDocuments()
        let groups = snapshot.documents.compactMap { document -> Group? in
            try? document.data(as: Group.self)
        }
        return groups
    }
    
    func getGroupsForUser(userId: String) -> [Group] {
        return groups.filter { group in
            group.teacherId == userId || (group.studentIds.contains(userId))
        }
    }
    
    func fetchUsers() async throws -> [User] {
        let snapshot = try await db.collection("users").getDocuments()
        let users = snapshot.documents.compactMap { document -> User? in
            try? document.data(as: User.self)
        }
        return users
    }
    
    func getTeacher(for group: Group) -> User? {
        guard let teacherId = group.teacherId else { return nil }
        return users.first { $0.id == teacherId }
    }
    
    func getStudents(for group: Group) -> [User] {
        return users.filter { group.studentIds.contains($0.id) }
    }
    
}
