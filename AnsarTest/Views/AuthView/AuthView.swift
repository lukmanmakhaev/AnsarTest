//
//  AuthView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        ZStack {
            if authViewModel.flow == .login {
                SignInView()
                    .environmentObject(authViewModel)
            }
            else {
                SignUpView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
}
