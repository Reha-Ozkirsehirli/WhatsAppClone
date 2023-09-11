//
//  UserModel.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 7.09.2023.
//

import Foundation

struct UserModel: Identifiable {
    var id = UUID()
    var name: String
    var uidFromFirebase: String
}
