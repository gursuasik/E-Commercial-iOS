//
//  GetOrderTableViewCell.swift
//  Master
//
//  Created by Gürsu Aşık on 17.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class GetOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
