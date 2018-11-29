//
//  GetOrderViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 17.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class GetOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var saleCode: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var saleCreateDate: UILabel!
    @IBOutlet weak var products: UITableView!
    @IBOutlet weak var paymentType: UILabel!
    @IBOutlet weak var addressType1: UILabel!
    @IBOutlet weak var addressType2: UILabel!
    @IBOutlet weak var sumPrice: UILabel!
    
    var data: String?
    var indicator: NVActivityIndicatorView!
    var getOrderResult : GetOrderResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
print(data)
        let request = GetOrderRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: data!)
        indicator.startAnimating()
        
        print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
            self.indicator.stopAnimating()
         
            print(response)
        }
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetOrderResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    self.getOrderResult = response.result.value
                    
                    self.saleCode.text = (self.getOrderResult?.data.saleCode)! + " Numaralı Siparişinizin Detayı"
                    
                    let status: String
                    switch self.getOrderResult?.data.status {
                    case 1?:
                        status = "Ödeme Bekliyor"
                    case 2?:
                        status = "Stok Bekliyor"
                    case 3?:
                        status = "Fatura Kes"
                    case 4?:
                        status = "Kargo Gönder"
                    case 5?:
                        status = "Sipariş Tamamlandı"
                    case 6?:
                        status = "Ürün İade Bekliyor"
                    case 7?:
                        status = "İade Faturası Bekliyor"
                    case 8?:
                        status = "Stok İade Bekliyor"
                    case 9?:
                        status = "Ödeme İade Bekliyor"
                    case 10?:
                        status = "İade Tamamlandı"
                    default:
                        status = "Geçersiz"
                    }
                    self.status.text = status
                    
                    let dateFormatter0 = DateFormatter()
                    dateFormatter0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "dd.MM.yyyy / HH:mm"
                    let date: NSDate? = dateFormatter0.date(from: (self.getOrderResult?.data.saleCreateDate)!) as! NSDate
                    self.saleCreateDate.text = dateFormatter1.string(from: date! as Date)
                    
                    self.products.reloadData()
                    
                    self.paymentType.text = self.getOrderResult?.data.payments[0].bankName
                    
                    for item in (self.getOrderResult?.data.addresses)! {
                        let address = item.nickName + " " + item.addressText + " " + item.townName + " / " + item.cityName
                        
                        switch item.type {
                            case 1:
                                self.addressType1.text = address
                            
                            case 2:
                                self.addressType2.text = address
                            
                            case 3:
                                self.addressType1.text = address
                                self.addressType2.text = address
                            
                            default: break
                        }
                    }
                    
                    self.sumPrice.text = String(format: "%.2f TL", (self.getOrderResult?.data.grandTotal)! as CVarArg)
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if getOrderResult == nil {
            return 0
        }
        
        return (getOrderResult?.data.details.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GetOrderTableViewCell
        
        Alamofire.request((getOrderResult?.data.details[indexPath.row].imagePath)!).responseData { response in
            if let data = response.data {
                cell.imageProduct.image = UIImage(data: data)
            }
        }

        cell.name.text = getOrderResult?.data.details[indexPath.row].name
        cell.price.text = String(format: "%.2f TL", (getOrderResult?.data.details[indexPath.row].salePrice)! as CVarArg)
        cell.color.text = getOrderResult?.data.details[indexPath.row].color
        cell.body.text = getOrderResult?.data.details[indexPath.row].body
        cell.quantity.text = String(describing: (getOrderResult?.data.details[indexPath.row].quantity)!)
        
        return cell
    }
}
