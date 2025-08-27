//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if let user = profileViewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading ...")
                }
            }.navigationTitle("Profile")
        }.onAppear {
            profileViewModel.fetchUser()
        }
            
        
    }
    
    
    @ViewBuilder
    func profile(user: UserModel) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
        
        VStack(alignment: .leading) {
            HStack {
                Text("Name:").bold()
                Text("\(user.name)")
            }.padding()
            HStack {
                Text("Email:").bold()
                Text("\(user.email)")
            }.padding()
            
            HStack {
                Text("Member Since:").bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }.padding()
        }
        
        TLButton(title: "Logout",
                 backgroundColor: Color.clear,
                 foregroundColor: Color.red
        ) {
            profileViewModel.logout()
        }
        
        Spacer()
    }
    
}

#Preview {
    ProfileView()
}
