//
//  FastDeliveryTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class FastDeliveryTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var note: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
