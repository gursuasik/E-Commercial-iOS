//
//  BannerTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 1.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
