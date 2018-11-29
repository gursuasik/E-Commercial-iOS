//
//  DenemeButton.swift
//  Master
//
//  Created by Gürsu Aşık on 16.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

protocol dropDownProtocol {
    func dropDownPressed(string: String)
}

class DropDownButton: UIButton, dropDownProtocol {
    var dropView = dropDownView()
    var height = NSLayoutConstraint()
    var anchorIsActive = Bool()
    
    @IBInspectable
    var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dropView = dropDownView.init(frame: CGRect.init(x: 10, y: 10, width: 10, height: 10))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false

        anchorIsActive = true
    }

    override func didMoveToSuperview() {
        self.superview?.bringSubview(toFront: dropView)
        self.superview?.addSubview(dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = anchorIsActive
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = anchorIsActive
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = anchorIsActive
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            anchorIsActive = false
        }
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 100 {
                self.height.constant = 150
            }
            else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
        }
        else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
        }
    }

    func dismissDropDown() {
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }

    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        dismissDropDown()
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource{
    var dropDownOption = [String]()
    var dropDownOptionId: Int?
    var tableView = UITableView()
    var delegate: dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //dropDownOption = ["Kadın", "Erkek"]
        
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOption[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOption[indexPath.row])
        dropDownOptionId = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
