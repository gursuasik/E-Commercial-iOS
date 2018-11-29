//
//  PaymentTypesViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 31.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class PaymentTypesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = ""
        
        paymentTypeData = [PaymentTypesCell(image: "visa", name: "Kredi Kartı"), PaymentTypesCell(image: "bkm", name: "BKM Express"), PaymentTypesCell(image: "havale", name: "Havale")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return paymentTypeData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentTypeTableViewCell
        
        cell.paymentImageName.image = UIImage(named: paymentTypeData[indexPath.row].image)
        cell.name.text = paymentTypeData[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPaymentTypeIndex = indexPath.row
        
        performSegue(withIdentifier: "creditCard", sender: self)
        
        /*let viewController = ProductDescriptionViewController()
         viewController.productCode = productCode
         navigationController?.pushViewController(viewController, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
}

class PaymentTypesCell {
    let image: String
    let name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
