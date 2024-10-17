//
//  ContentView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 16.10.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            Button(action: {
                authViewModel.signOut()
            }, label: {
                Text("Logout")
            }) 
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
