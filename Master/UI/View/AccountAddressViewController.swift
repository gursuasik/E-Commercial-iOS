//
//  AccountAddressesViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 7.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class AccountAddressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var addressType: Int?
    var indicator: NVActivityIndicatorView!
    var getAddressListResult: GetAddressListResult?
    var addressId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
    }

    override func viewWillAppear(_ animated: Bool) {
        getAddressList()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountAddressTableViewCell
        
        cell.nickName.text = getAddressListResult?.data[indexPath.row].nickName
        cell.addressText.text = getAddressListResult?.data[indexPath.row].addressText
        cell.area.text = (getAddressListResult?.data[indexPath.row].townName)! + " / " + (getAddressListResult?.data[indexPath.row].cityName)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressId = (getAddressListResult?.data[indexPath.row].id)!
        
        performSegue(withIdentifier: "getAddress", sender: self)
    }
    
    //IOS 10-
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "SİL", handler:{action, indexpath in
            print("DELETE•ACTION");
        });
        //deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "trash")!)
        //deleteAction.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        
        /*var cancelRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "     ", handler:{action, indexpath in
         print("Cancel Row Action");
         });
         cancelRowAction.backgroundColor = UIColor(patternImage: UIImage(named: "cancel2Kopya")!)
         
         return [deleteAction, cancelRowAction];*/
        return [deleteAction];
    }
    
    //IOS 11+
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction =  UIContextualAction(style: .normal, title: "", handler: { (action, view, completionHandler) in
            let request = DeleteAddressRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, type: self.addressType!, id: (self.getAddressListResult?.data[indexPath.row].id)!)
            self.indicator.startAnimating()
            print(request.getParameters())
            /*Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
             self.indicator.stopAnimating()
             
             print(response)
            }*/
            Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseDeleteAddressResult { response in
                self.indicator.stopAnimating()
                
                switch response.result {
                case .success(let json):
                    if let result = response.result.value {
                        if result.success {
                            let alert = UIAlertController(title: "Tebrikler", message: "Adresiniz silindi!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { action in
                                self.getAddressList()
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            let alert = UIAlertController(title: "Dikkat", message: result.message, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        })
        deleteAction.image = UIImage(named: "trash")
        deleteAction.backgroundColor = UIColor(red: 14/255, green: 14/255, blue: 14/255, alpha: 255/255)
        
        let confrigation = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return confrigation
    }
    
    func getAddressList() {
        let request = GetAddressListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, type: addressType!)
        indicator.startAnimating()
        /*print(request.getParameters())
         Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetAddressListResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                self.getAddressListResult = response.result.value
                
                self.table.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "addAddress"?:
                let viewController = segue.destination as! AccountAddAddressViewController
                viewController.addressType = addressType
            
            case "getAddress"?:
                let viewController = segue.destination as! GetAddressViewController
                viewController.addressType = addressType
                viewController.addressId = addressId
            
            default: break
            
        }
    }
}
