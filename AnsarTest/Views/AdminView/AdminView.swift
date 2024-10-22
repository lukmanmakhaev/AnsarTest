//
//  AdminView.swift
//  AnsarTest
//
//  Created by Lukman Makhaev on 17.10.2024.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var global = Global.shared
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false) {
                HStack {
                    NavigationLink(destination: {
                        
                        ScrollView {
                            VStack {
                                let filteredUsers = global.users.filter { user in
                                    user.userType == .teacher
                                }
                                ForEach(filteredUsers, id: \.name) { user in
                                    Button(action: {
                                        
                                    }, label: {
                                        UserlistItemView(user: user, isPickerShown: true)
                                    })
                                }
                            }
                            .padding()
                            
                        }
                        .navigationTitle("Teachers")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(.visible, for: .navigationBar)
                        
                    }, label: {
                        
                        VStack {
                            Image(systemName: "person.bust.fill")
                            Text("Teachers")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                        .fontWeight(.bold)
                        .padding()
                        .background(.item)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                    })
                    
                    NavigationLink(destination: {
                        
                        ScrollView {
                            VStack {
                                let filteredUsers = global.users.filter { user in
                                    user.userType == .student
                                }
                                ForEach(filteredUsers, id: \.name) { user in
                                    Button(action: {
                                        
                                    }, label: {
                                        UserlistItemView(user: user, isPickerShown: true)
                                    })
                                }
                            }
                            .padding()
                        }
                        .navigationTitle("Students")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(.visible, for: .navigationBar)
                        
                    }, label: {
                        
                        VStack {
                            Image(systemName: "person.3.sequence.fill")
                            Text("Students")
                        }
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                        .padding()
                        .background(.item)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        
                    })
                }
                .foregroundStyle(.black)
                .padding(.top)
                
                Button(action: {
                    
                }, label: {
                    
                    Text("Moderators")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.item)
                        .cornerRadius(15)
                        .foregroundStyle(.black)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                })
                
                Text("GROUPS")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.gray)
                
                ForEach($global.groups) { $group in
                    NavigationLink(destination: {
                        CreateGroupView(newGroup: group, title: "Details", buttonName: "Done")
                    }, label: {
                        GroupListitemView(group: $group)
                    })
                }
            }
            .padding(.horizontal)
            .navigationTitle("Admin Panel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Log out")
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            
            NavigationLink(destination: {
                CreateGroupView()
            }, label: {
                
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New group")
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(.accent)
                .cornerRadius(15)
                .fontWeight(.semibold)
                .padding()
            })
        }
    }
}

#Preview {
    AdminView()
        .environmentObject(AuthViewModel())
        .environmentObject(AdminViewModel())
}
