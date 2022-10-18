//
//  PostCell.swift
//  Instagram
//
//  Created by Luis Rivera Rivera on 10/7/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var authorProfilePhoto: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var photoCaption: UILabel!
    @IBOutlet weak var authorNameTopLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
