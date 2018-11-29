//
//  CustomHeader.swift
//  Master
//
//  Created by Gürsu Aşık on 28.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

protocol CustomHeaderDelegate: class {
    func toggleSection(header: CustomHeader, section: Int)
}

// define CustomHeader class with necessary `delegate`, `@IBOutlet` and `@IBAction`:

class CustomHeader: UITableViewHeaderFooterView {
    weak var delegate: CustomHeaderDelegate?
    var section: Int!
    
    @IBOutlet weak var customLabel: UILabel!
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.black
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! CustomHeader
        delegate?.toggleSection(header: self, section: cell.section)
    }
}
