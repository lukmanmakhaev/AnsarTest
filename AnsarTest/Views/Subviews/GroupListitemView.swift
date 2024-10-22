//
//  GroupListitemView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 19.10.2024.
//

import SwiftUI

struct GroupListitemView: View {
    @Binding var group: Group
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(group.name)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("text"))
                
                
                Text(group.description)
                    .font(.system(size: 14))
                    .lineLimit(1)
                    .foregroundStyle(Color.grayText)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if group.studentIds.count > 0 {
                Text("\(group.studentIds.count)")
                    .font(.system(size: 14).bold())
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(Circle()
                        .fill(.accent))
            }
        }
        .padding()
        .background(.item)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.15), radius: 2)
    }
}

#Preview {
    GroupListitemView(group: .constant(Group(id: "", name: "Python", description: "Enter group", teacherId: "", studentIds: [""])))
}
