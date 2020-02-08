//
//  ChatViewController.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 05/02/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var footerView: UIView!

    let chatViewModel : ChatViewModel = ChatViewModel()
    @IBOutlet weak var txtFieldMessage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChatBot"
        setupChatMessages()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);

        }

    func setupChatMessages() {
        chatViewModel.addMessage(message: "are you building a chat bot?")
        chatViewModel.addMessage(message: "i can help and guide you")
        chatViewModel.addMessage(message: "i can provide you list of api you need to setup")
        tableView.reloadData()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height - (self.tabBarController?.tabBar.frame.size.height ?? 0)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
             if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
             }
    }
    @IBAction func handleSendMessage(_ sender: Any) {
        addMessage()
    }

    //add chat message
    func addMessage() {
        if let messageContent = txtFieldMessage.text {
            chatViewModel.addMessage(message: messageContent)
            tableView.insertRows(at: [IndexPath(row: chatViewModel.messages.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
            txtFieldMessage.resignFirstResponder()
            tableView.scrollsToTop = true
        }
    }
}

extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatViewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        chatCell.configureCell(message: chatViewModel.messages[indexPath.row])
        return chatCell
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return footerView
//    }
}
