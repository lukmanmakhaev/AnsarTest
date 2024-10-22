//
//  ContentView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 16.10.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var adminViewModel: AdminViewModel
    
    var body: some View {
        NavigationView {
            if let userType = authViewModel.currentUser?.userType {
                switch userType {
                case .admin:
                    AdminView()
                case .teacher:
                    TeacherView()
                case .student:
                    StudentView()
                }
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel())
        .environmentObject(AdminViewModel())
}
