//
//  ChatStore.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 11.09.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class ChatStore: ObservableObject {
    let firestore = Firestore.firestore()
    var chatArray: [ChatModel] = []
    var objectWillChange = PassthroughSubject<Array<Any>,Never>()
    
    init() {
        firestore.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { snapshot, err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    self.chatArray.removeAll()
                    snapshot?.documents.forEach({ document in
                        let chatUid = document.documentID
                        if let chatMessage = document.get("message") as? String, let messageFrom = document.get("chatUserFrom") as? String, let messageTo = document.get("chatUserTo") as? String, let dateString = document.get("date") as? String {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                            let date = dateFormatter.date(from: dateString)
                            let chat = ChatModel(message: chatMessage, chatUid: chatUid, messageFrom: messageFrom, messageTo: messageTo, messageDate: date!, messageFromMe: true)
                            self.chatArray.append(chat)
                        }
                    })
                    self.firestore.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid)
                        .addSnapshotListener { snapshot, err in
                            if let err = err {
                                print(err.localizedDescription)
                            } else {
                                snapshot?.documents.forEach({ document in
                                    let chatUid = document.documentID
                                    if let chatMessage = document.get("message") as? String, let messageFrom = document.get("chatUserFrom") as? String, let messageTo = document.get("chatUserTo") as? String, let dateString = document.get("date") as? String {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                        let date = dateFormatter.date(from: dateString)
                                        let chat = ChatModel(message: chatMessage, chatUid: chatUid, messageFrom: messageFrom, messageTo: messageTo, messageDate: date!, messageFromMe: true)
                                        self.chatArray.append(chat)
                                    }
                                })
                                self.chatArray.sort { m1, m2 in
                                    m1.messageDate.compare(m2.messageDate) == .orderedAscending
                                }
                                self.objectWillChange.send(self.chatArray)
                            }
                        }
                }
            }
    }
}
