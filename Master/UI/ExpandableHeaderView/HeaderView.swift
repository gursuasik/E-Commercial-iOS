//
//  HeaderView.swift
//  Master
//
//  Created by Gürsu Aşık on 1.10.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var customLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
