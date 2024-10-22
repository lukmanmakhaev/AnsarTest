//
//  AnsarTestApp.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 16.10.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AnsarTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var adminViewModel = AdminViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch authViewModel.authenticationState {
                case .unauthenticated:
                    AuthView()
                        .environmentObject(authViewModel)
                case .authenticating:
                    ProgressView()
                case .authenticated:
                    MainView()
                        .environmentObject(authViewModel)
                        .environmentObject(adminViewModel)
                }
            }
        }
    }
}
