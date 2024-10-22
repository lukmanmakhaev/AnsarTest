//
//  StudentsList.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 18.10.2024.
//

import SwiftUI

struct StudentsList: View {
    @ObservedObject var global = Global.shared
    @Binding var group: Group
    
    func toggleStudentSelection(userId: String) {
           if group.studentIds.contains(userId) {
               group.studentIds.removeAll { $0 == userId }
           } else {
               group.studentIds.append(userId)
           }
       }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                let filteredUsers = global.users.filter { user in
                    user.userType == .student
                }
                
                ForEach(filteredUsers, id: \.name) { user in
                    Button(action: {
                        toggleStudentSelection(userId: user.id)
                            
                    }, label: {
                        UserlistItemView(user: user, isSelected: group.studentIds.contains(user.id), isSelectable: true)
                    })
                }
            }
            .navigationTitle("Students")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .padding()
    }
}

#Preview {
    StudentsList(group: .constant(Group(id: "", name: "", description: "")))
}
