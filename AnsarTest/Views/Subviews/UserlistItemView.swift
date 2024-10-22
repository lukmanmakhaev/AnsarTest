//
//  TeacherlistItemView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 18.10.2024.
//

import SwiftUI

struct UserlistItemView: View {
    @EnvironmentObject var adminViewModel: AdminViewModel
    @ObservedObject var global = Global.shared
    @State var user: User
    var isSelected: Bool = false
    var isSelectable: Bool = false
    var isPickerShown: Bool = false
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading) {
                Text(user.name)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("text"))
                
                
                Text(user.email)
                    .font(.system(size: 14))
                    .lineLimit(1)
                    .foregroundStyle(Color.grayText)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if isPickerShown {
                Picker("", selection: $user.userType) {
                    ForEach(UserType.allCases, id: \.self) { userType in
                        Text(userType.rawValue.capitalized)
                            .tag(userType)
                    }
                }
                .onChange(of: user.userType) { newValue in
                    user.userType = newValue
                    adminViewModel.updateUser(user: user)
                    global.loadData()
                }
                .padding(2)
                .background(Color("itemColor"))
                .cornerRadius(15)
            }
            
            if isSelectable {
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color("itemColor"))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.15), radius: 2)
    }
}

#Preview {
    UserlistItemView(user: User(id: "", name: "Artur Beterbiev", email: "arturb@gmail.com", bio: "", groupIds: [""], userType: .teacher), isSelected: true, isSelectable: false)
}
