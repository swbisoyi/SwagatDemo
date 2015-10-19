//
//  MenuTableViewCell.swift
//  Places Lookup
//
//  Created by Swagat Kumar Bisoyi on 10/18/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//



import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMenuTab: UIImageView!
    @IBOutlet weak var lblTabTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
