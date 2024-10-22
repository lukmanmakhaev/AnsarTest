//
//  TeachersList.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 18.10.2024.
//

import SwiftUI

struct TeachersList: View {
    @ObservedObject var global = Global.shared
    @Environment(\.dismiss) private var dismiss
    @Binding var group: Group
    
    var isSelectable = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                let filteredUsers = global.users.filter { user in
                    user.userType == .teacher
                }
                ForEach(filteredUsers, id: \.name) { user in
                    Button(action: {
                        if isSelectable {
                            group.teacherId = user.id
                            dismiss()
                        } 
                        
                    }, label: {
                        UserlistItemView(user: user, isSelectable: isSelectable, isPickerShown: true)
                    })
                }
            }
            .navigationTitle("Teachers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .padding()
    }
}

#Preview {
    TeachersList(group: .constant(Group(id: "", name: "", description: "")))
}
