//
//  UserTableViewCell.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"

    @IBOutlet var userImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView?.layer.cornerRadius = 8.0
        userImageView?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
