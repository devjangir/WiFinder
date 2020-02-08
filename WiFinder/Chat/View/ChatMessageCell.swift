//
//  ChatMessageCell.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 05/02/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    @IBOutlet weak var lblInitials: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblInitials.layer.cornerRadius = lblInitials.frame.size.width / 2
        lblInitials.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(message: Message) {
        lblMessage.text = message.message
    }
}
