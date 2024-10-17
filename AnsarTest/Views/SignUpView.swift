//
//  SignUpView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

private enum FocusableField: Hashable {
    case name
    case email
    case password
}

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @FocusState private var focus: FocusableField?
    @Environment(\.dismiss) var dismiss
    
    private func signUpWithEmailPassword() {
        Task {
            if await authViewModel.signUpWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        
        VStack (spacing: 16) {
            
            VStack (alignment: .leading, spacing: 0) {
                
                Text("Name")
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                
                TextField("John Doe", text: $authViewModel.name)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                    .focused($focus, equals: .name)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .email
                    }
                    .padding(.top, 12)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                
            }
            
            VStack (alignment: .leading, spacing: 0) {
                
                Text("Email")
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                
                TextField("xyz@gmail.соm", text: $authViewModel.email)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
                    .padding(.top, 12)
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
                                    //signUpWithEmailPassword()
                                }
                        } else {
                            TextField("Your password", text: $authViewModel.password)
                                .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                                .textInputAutocapitalization(.never)
                                .focused($focus, equals: .password)
                                .submitLabel(.go)
                                .onSubmit {
                                    //signUpWithEmailPassword()
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
                signUpWithEmailPassword()
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                
            }
            .padding(.top)

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            HStack {
                Text("Already have an account?")
                Button(action: { authViewModel.switchFlow() }) {
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}


#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
