//
//  GetDiscountCouponListTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 25.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class GetDiscountCouponListTableViewCell: UITableViewCell {
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var isValid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
