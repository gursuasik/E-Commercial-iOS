//
//  Cell.swift
//  Master
//
//  Created by Gürsu Aşık on 8.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = CGFloat(300)
        widthConstraint.constant = screenWidth - (2 * 12)*/
        
        //let screenWidth = UIScreen.main.bounds.size.width
        //widthConstraint.constant = screenWidth - (2 * 12)
    }

}
