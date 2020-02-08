//
//  MediaTableViewCell.swift
//  WiFinder
//
//  Created by Devdutt Jangir on 31/01/20.
//  Copyright © 2020 devjangir. All rights reserved.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewArtwork: UIImageView!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(model: Media, type: Int) {
        if(type == 0) {
            //imageViewArtwork.image = nil
            imageViewArtwork.sd_setImage(with: URL(string: model.artworkUrl100))
            lblArtistName.text = model.trackName
            lblDescription.text = model.artistName
        } else if(type == 1) {

        } else {

        }

    }

}
