//
//  SignInView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

private enum FocusableField: Hashable {
    case email
    case password
}

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    @FocusState private var isFocused: Bool
    
    private func signInWithEmailPassword() {
        Task {
            if await authViewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack (spacing: 16) {
            VStack (alignment: .leading, spacing: 0) {
                
                Text("Email")
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                
                TextField("xyz@gmail.соm", text: $authViewModel.email)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                    .textInputAutocapitalization(.never)
                    .padding(.top, 12)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                
            }
            
            VStack (alignment: .leading, spacing: 0) {
                Text("Password")
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                
                ZStack(alignment: .trailing) {
                    VStack {
                        if authViewModel.isSecured {
                            SecureField("••••••••", text: $authViewModel.password)
                                .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                                .textInputAutocapitalization(.never)
                                .focused($focus, equals: .password)
                                .submitLabel(.go)
                                .onSubmit {
                                    signInWithEmailPassword()
                                }
                        } else {
                            TextField("Your password", text: $authViewModel.password)
                                .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                                .textInputAutocapitalization(.never)
                                .focused($focus, equals: .password)
                                .submitLabel(.go)
                                .onSubmit {
                                    signInWithEmailPassword()
                                }
                        }
                    }
                    .padding(.trailing, 32)
                    
                    Button(action: {
                        authViewModel.isSecured.toggle()
                    }) {
                        Image(systemName: authViewModel.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                    .padding(.trailing)
                }
                .background(Color("itemColor"))
                .cornerRadius(15)
                .padding(.top, 12)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                
            }
            
            Button(action: {
                signInWithEmailPassword()
            }) {
                Text("Sign in")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                
            }
            .padding(.top)
            
            Button(action: {
                // add reset function
            }) {
                Text("Забыли пароль?")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 8)
            }
            
            Spacer()
            
            HStack {
                Text("Dont have cccount")
                Button(action: { authViewModel.switchFlow() }) {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
