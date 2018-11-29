//
//  BasketViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 28.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var products: UITableView!
    @IBOutlet weak var sumPrice: UILabel!
    
    var indicator: NVActivityIndicatorView!
    //var openLogin: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = ""
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        //openLogin = true
        
        getOrder()
    }

    override func viewWillAppear(_ animated: Bool) {
        /*if tokenResult != nil {
            getOrder()
        }
        else if openLogin! {
            openLogin = false
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else {
            dismiss(animated: true, completion: nil)
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if getOrderBasketResult == nil {
            return 0
        }
        
        return (getOrderBasketResult?.data.details.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketTableViewCell
        
        Alamofire.request((getOrderBasketResult?.data.details[indexPath.row].imagePath)!).responseData { response in
            if let data = response.data {
                cell.imageProduct.image = UIImage(data: data)
            }
        }
        
        cell.name.text = getOrderBasketResult?.data.details[indexPath.row].name
        cell.price.text = String(format: "%.2f TL", (getOrderBasketResult?.data.details[indexPath.row].salePrice)! as CVarArg)
        cell.color.text = getOrderBasketResult?.data.details[indexPath.row].color
        cell.body.text = getOrderBasketResult?.data.details[indexPath.row].body
        
        return cell
    }
    
    //IOS 10-
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "SİL", handler:{action, indexpath in
            let request = DeleteProductRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: (getOrderBasketResult?.data.details[indexPath.row].uniqNo)!)
            self.indicator.startAnimating()
            
            Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseDeleteProductResult { (response: DataResponse<DeleteProductResult>) in
                self.indicator.stopAnimating()
                
                switch response.result {
                case .success(let json):
                    if let result = response.result.value {
                        if result.success {
                            let alert = UIAlertController(title: "Tebrikler", message: "Ürününüz sepetten çıkarıldı!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { action in
                                self.getOrder()
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
            let request = DeleteProductRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: (getOrderBasketResult?.data.details[indexPath.row].uniqNo)!)
            self.indicator.startAnimating()
            
            Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseDeleteProductResult { (response: DataResponse<DeleteProductResult>) in
                self.indicator.stopAnimating()
                
                switch response.result {
                case .success(let json):
                    if let result = response.result.value {
                        if result.success {
                            let alert = UIAlertController(title: "Tebrikler", message: "Ürününüz sepetten çıkarıldı!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { action in
                                self.getOrder()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129
    }
    
    func getOrder() {
        let request = GetOrderBasketRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!)
        indicator.startAnimating()
        
        //print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
            self.indicator.stopAnimating()
            
            print(response)
        }
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetOrderBasketResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    if let result = response.result.value {
                        getOrderBasketResult = result

                        if getOrderBasketResult?.data.details.count == 0 {
                            let alert = UIAlertController(title: "Dikkat", message: "Sepetinizde ürün yok! Sepetinize ürün eklemelisiniz.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: { action in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            self.products.reloadData()
                            
                            self.sumPrice.text = String(format: "%.2f TL", (getOrderBasketResult?.data.grandTotal)! as CVarArg)
                        }
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
    }
}
