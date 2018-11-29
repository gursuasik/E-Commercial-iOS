//
//  ProductDescriptionTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 5.10.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
