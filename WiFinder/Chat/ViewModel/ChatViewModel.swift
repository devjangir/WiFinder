//
//  ChatViewModel.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 05/02/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import Foundation

class ChatViewModel {
    var messages : [Message] = []
    func addMessage(message : String) {
        messages.append(Message(message: message))
    }
}
