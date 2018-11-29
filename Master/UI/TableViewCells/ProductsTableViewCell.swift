//
//  ProductsTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 2.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
