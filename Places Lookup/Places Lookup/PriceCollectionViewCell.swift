//
//  PriceCollectionViewCell.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/25/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
    }
}
