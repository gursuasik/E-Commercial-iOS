//
//  GetOrdersTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 14.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class GetOrdersTableViewCell: UITableViewCell {
    @IBOutlet weak var saleCode: UILabel!
    @IBOutlet weak var saleCreateDate: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
