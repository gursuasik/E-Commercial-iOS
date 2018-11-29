//
//  AddressTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 31.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
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
