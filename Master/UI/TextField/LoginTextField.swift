//
//  LoginTextField.swift
//  Master
//
//  Created by Gürsu Aşık on 15.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

@IBDesignable
class LoginTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.layer.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
        //self.layer.borderWidth = 1
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
