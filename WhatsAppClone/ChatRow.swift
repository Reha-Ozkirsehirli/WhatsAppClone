//
//  ChatRow.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 11.09.2023.
//

import FirebaseAuth
import SwiftUI
struct ChatRow: View {
    var chatMessage: ChatModel
    var userToChat: UserModel

    var body: some View {
        Group {
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChat.uidFromFirebase {
                HStack {
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.green)
                        .padding(10)
                }
            } else if chatMessage.messageFrom == userToChat.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser!.uid {
                HStack {
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(10)
                    Spacer()
                }
            }
        }.frame(width: UIScreen.main.bounds.width * 0.95)
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(message: "Asd", chatUid: "asdasd", messageFrom: "ASdasd", messageTo: "ASdafs", messageDate: Date(), messageFromMe: true), userToChat: UserModel(name: "asfsa", uidFromFirebase: "Afweagfewg"))
    }
}
