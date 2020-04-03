//
//  SentMemeTableViewCell.swift
//  MemeDemo
//
//  Created by Makaveli Ohaya on 4/2/20.
//  Copyright © 2020 Ohaya. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    
        @IBOutlet weak var TopTextLabel: UILabel!
        @IBOutlet weak var BottomTextLabel: UILabel!
        
        @IBOutlet weak var thumbnailImageView: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
