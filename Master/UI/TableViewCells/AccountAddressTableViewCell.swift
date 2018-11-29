//
//  DeliveryAddressTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 10.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class AccountAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var area: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
