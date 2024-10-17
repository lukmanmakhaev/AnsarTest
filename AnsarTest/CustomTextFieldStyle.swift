//
//  CustomTextFieldStyle.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool
    @State var backgroundColor: String
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .disableAutocorrection(true)
            .background(Color(backgroundColor))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15).stroke(.blue, lineWidth: 0))
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
