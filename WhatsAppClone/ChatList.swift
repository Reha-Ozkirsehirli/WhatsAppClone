//
//  ChatList.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 7.09.2023.
//

import FirebaseAuth
import SwiftUI

struct ChatList: View {
//    @ObservedObject var userStore = UserStore()
    @EnvironmentObject var userStore: UserStore
    
    @State var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                List(userStore.userArray) { user in
                    NavigationLink {
                        ChatView(userToChat: user)
                    } label: {
                        Text(user.name)
                    }
                }
                Button {
                    do {
                        try Auth.auth().signOut()
                        isPresented = true
                    } catch let err {
                        print("sign out faild: \(err.localizedDescription)")
                    }
                } label: {
                    Text("SignOut")
                }
                .navigationDestination(isPresented: $isPresented) {
                    AuthView()
                }
            }
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
