//
//  TeacherView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

struct TeacherView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var global = Global.shared
    var body: some View {
        NavigationStack {
            VStack {
                Text("Teachers Account")
                    .font(.title)
                
                Text("GROUPS")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.gray)
                
                ForEach(global.getGroupsForUser(userId: authViewModel.currentUser?.id ?? "")) { group in
                    Button(action: {
                        
                    }, label: {
                        GroupListitemView(group: .constant(group))
                    })
                }
            }
            .padding()
            .navigationTitle("Ansar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Log out")
                    }
                }
            }
        }
    }
}

#Preview {
    TeacherView()
        .environmentObject(AuthViewModel())
        .environmentObject(AdminViewModel())
}
