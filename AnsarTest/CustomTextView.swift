//
//  CustomTextView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 18.10.2024.
//

import SwiftUI

struct CustomTextView: View {
    var text: String
    var placeholder: String
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            
            HStack {
                if text.isEmpty {
                    Text(placeholder)
                        .padding()
                        .foregroundColor(.grayText)
                } else {
                    Text(text)
                        .padding()
                }
                Spacer()
            }
            .background(.item)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 2)
        }
    }
}
#Preview {
    CustomTextView(text: "Description", placeholder: "Placeholder")
}
