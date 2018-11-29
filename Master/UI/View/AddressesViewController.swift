//
//  DeliveryViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 31.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class AddressesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var addresses: UITableView!
    
    var indicator: NVActivityIndicatorView!
    var selectAreaId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        let request = GetAddressListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, type: 1)
        indicator.startAnimating()

        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetAddressListResult { (response: DataResponse<GetAddressListResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    getAddressListResult = response.result.value

                    self.addresses.reloadData()
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if getAddressListResult == nil {
            return 0
        }
        
        return (getAddressListResult?.data.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
        
        cell.nickName.text = getAddressListResult?.data[indexPath.row].nickName
        cell.addressText.text = getAddressListResult?.data[indexPath.row].addressText
        cell.area.text = (getAddressListResult?.data[indexPath.row].townName)! + " / " + (getAddressListResult?.data[indexPath.row].cityName)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = SetOrderAddressRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, IsFastDelivery: false, InvoiceId: (getAddressListResult?.data[indexPath.row].id)!, UseDelivery: "true")
        indicator.startAnimating()
        
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseSetOrderAddressResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    let setOrderAddressResult = response.result.value
                    if (setOrderAddressResult?.success)! {
                        if getAddressListResult?.data[indexPath.row].areaID == nil {
                            self.selectAreaId = 0
                        }
                        else {
                            self.selectAreaId = Int((getAddressListResult?.data[indexPath.row].areaID)!)
                        }
                        selectAddressIndex = indexPath.row
                        
                        self.performSegue(withIdentifier: "fastDelivery", sender: self)
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
        
        /*let viewController = ProductDescriptionViewController()
         viewController.productCode = productCode
         navigationController?.pushViewController(viewController, animated: true)*/
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fastDelivery") {
            let viewController = segue.destination as! FastDeliveryViewController
            viewController.areaId = selectAreaId
        }
    }
}
