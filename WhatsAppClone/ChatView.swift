//
//  ChatView.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 11.09.2023.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct ChatView: View {
    var firestore = Firestore.firestore()
    var userToChat: UserModel
    
    @State var message = ""
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        VStack {
            
            ScrollView {
                ForEach(chatStore.chatArray) { chats in
                    ChatRow(chatMessage: chats, userToChat: userToChat)
                }
            }

            HStack {
                TextField("Message", text: $message)
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: 50).padding()
        }
    }

    func sendMessage() {
        let chatDictionary: [String: Any] = ["chatUserFrom": Auth.auth().currentUser!.uid, "chatUserTo": userToChat.uidFromFirebase, "date": generateDate(), "message": message]
        _ = firestore.collection("Chats").addDocument(data: chatDictionary, completion: { err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                message = ""
            }
        })
    }
    
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(name: "asfasf", uidFromFirebase: "Afaqfwaeg"))
    }
}
