//
//  AuthViewModel.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 16.10.2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String?
    
    @Published var isLoading: Bool = true
    @Published var flow: AuthenticationFlow = .login
    
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userType: UserType = .student
    @Published var isSecured: Bool = true
    
    init() {
        registerAuthStateHandler()
        
        Task {
            await fetchUser()
            self.isLoading = false
        }
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler() {
        self.isLoading = true
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.userSession = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            }
        }
    }
    
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            let result = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            self.userSession = result.user
            print("Sign in function called and \(String(describing: self.userSession?.email))")
            await fetchUser()
            reset()
            return true
        }
        catch  {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do  {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: userSession?.uid ?? "", name: self.name, email: self.email, isAdmin: false, userType: self.userType.rawValue)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            emailVerification()
            print("Sign up function called and \(String(describing: self.userSession?.email))")
            await fetchUser()
            reset()
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func emailVerification() {
        Auth.auth().currentUser?.sendEmailVerification()
    }
    
    func reset() {
        email = ""
        password = ""
        name = ""
        errorMessage = nil
    }
    
    func switchFlow() {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
    }
    
    func fetchUser() async {
        guard let uid = userSession?.uid else {
            return
            
        }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)

    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            reset()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
