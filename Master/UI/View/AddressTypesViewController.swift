//
//  AddressTypesViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 10.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class AddressTypesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableData = [String?]()
    var addressType: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backItem?.title = "Geri"
        navigationController?.navigationBar.tintColor = .black

        self.navigationController?.isNavigationBarHidden = false
        
        tableData = ["Fatura Adresim", "Teslimat Adresim"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTypeTableViewCell
        
        cell.name.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressType = indexPath.row + 1

        performSegue(withIdentifier: "address", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "address") {
            let viewController = segue.destination as! AccountAddressViewController
            viewController.addressType = addressType
        }
    }
}
