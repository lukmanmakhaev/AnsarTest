//
//  CreateGroupView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

struct CreateGroupView: View {
    @EnvironmentObject var adminViewModel: AdminViewModel
    @ObservedObject var global = Global.shared
    @Environment(\.dismiss) private var dismiss
    
    @State var newGroup = Group(id: UUID().uuidString, name: "", description: "", teacherId: "", studentIds: [])
    
    var title: String = "Create Group"
    var buttonName: String = "Create"
    
    func toggleStudentSelection(userId: String) {
        
        if newGroup.studentIds.contains(userId) {
            // Remove the user if already selected
            newGroup.studentIds.removeAll { $0 == userId }
        } else {
            // Add the user if not selected
            newGroup.studentIds.append(userId)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 12) {
                
                TextField("Name", text: $newGroup.name)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                    .submitLabel(.next)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                
                TextField("Description", text: $newGroup.description)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: "itemColor"))
                    .submitLabel(.next)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                
                NavigationLink {
                    TeachersList(group: $newGroup, isSelectable: true)
                } label: {
                    ZStack {
                        
                        CustomTextView(text: newGroup.teacher?.name ?? "", placeholder: "Tap to select a teacher")
                        
                        if newGroup.teacherId != "" {
                            Button(action: {
                                newGroup.teacherId = ""
                            }, label: {
                                HStack {
                                    Spacer()
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .padding()
                            })
                        }
                    }
                }
                
                Text("STUDENTS")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.gray)
                
                ForEach(newGroup.students ?? []) { student in
                    ZStack {
                        UserlistItemView(user: student, isSelected: false)
                            .padding(0)
                        Button(action: {
                            toggleStudentSelection(userId: student.id)
                        }, label: {
                            HStack {
                                Spacer()
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.red)
                            }
                            .padding()
                        })
                    }
                }
                
                NavigationLink(destination: {
                    StudentsList(group: $newGroup)
                    
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Students")
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(.accent)
                    .cornerRadius(15)
                    .fontWeight(.semibold)
                })
                
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        adminViewModel.createGroup(group: newGroup)
                        global.loadData()
                        dismiss()
                    }) {
                        Text(buttonName)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    CreateGroupView()
        .environmentObject(AdminViewModel())
}
