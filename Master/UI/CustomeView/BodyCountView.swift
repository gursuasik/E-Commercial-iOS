//
//  BodyCountView.swift
//  Master
//
//  Created by Gürsu Aşık on 13.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class BodyCountView: UIView {
    @IBOutlet weak var body: UIButton!
    @IBOutlet weak var reduce: UIButton!
    @IBOutlet weak var increment: UIButton!
    @IBOutlet weak var count: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        let view = Bundle.main.loadNibNamed("BodyCountView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
