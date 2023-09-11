//
//  UserStore.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 7.09.2023.
//

import Combine
import FirebaseFirestore
import SwiftUI

class UserStore: ObservableObject {
    let db = Firestore.firestore()
    var userArray: [UserModel] = []
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()

    init() {
        db.collection("Users").addSnapshotListener { snapshot, err in
            if let err = err {
                print(err.localizedDescription)
            } else {
                snapshot?.documents.forEach({ document in
                    if let uidFromFirebase = document.get("uuid") as? String {
                        if let userName = document.get("username") as? String {
                            let user = UserModel(name: userName, uidFromFirebase: uidFromFirebase)
                            self.userArray.append(user)
                        }
                    }
                })
                self.objectWillChange.send(self.userArray)
            }
        }
    }
}
