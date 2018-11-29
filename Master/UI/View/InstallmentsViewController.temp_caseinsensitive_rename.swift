//
//  installmentsViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/ {
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(data)
        /*let request = GetPaymentViewerRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: "")
        indicator.startAnimating()
        
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetAddressListResult { (response: DataResponse<GetAddressListResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                self.getAddressListResult = response.result.value
                
                self.addresses.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return paymentTypeData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentTypeTableViewCell
        
        cell.paymentImageName.image = UIImage(named: paymentTypeData[indexPath.row].image)
        cell.name.text = paymentTypeData[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //productCode = searchResult?.data.products[indexPath.row].productCode
        
        performSegue(withIdentifier: "creditCard", sender: self)
    }*/
}
