//
//  ChatModel.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 11.09.2023.
//

import Foundation

struct ChatModel: Identifiable {
    var id = UUID()
    var message: String
    var chatUid: String
    var messageFrom: String
    var messageTo: String
    var messageDate: Date
    var messageFromMe: Bool
}
