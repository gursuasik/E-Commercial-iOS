//
//  GetOrdersViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 14.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class GetOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var indicator: NVActivityIndicatorView!
    var getOrdersResult: GetOrdersResult?
    var saleCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        self.navigationController?.isNavigationBarHidden = false
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        let request = GetOrdersRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: 10000)
        indicator.startAnimating()
        /*
        print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
        }*/
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetOrdersResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    self.getOrdersResult = response.result.value
                    
                    self.table.reloadData()
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getOrdersResult == nil {
            return 0
        }
        
        return (getOrdersResult?.data.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GetOrdersTableViewCell
        
        let dateFormatter0 = DateFormatter()
        dateFormatter0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.z"
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date: NSDate? = dateFormatter0.date(from: (getOrdersResult?.data[indexPath.row].saleCreateDate)!) as! NSDate
        
        let status: String
        switch getOrdersResult?.data[indexPath.row].status {
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
        
        cell.saleCode.text = getOrdersResult?.data[indexPath.row].saleCode
        cell.saleCreateDate.text = dateFormatter1.string(from: date! as Date)
        cell.status.text = status
        cell.grandTotal.text = String(format: "%.2f TL", (getOrdersResult?.data[indexPath.row].grandTotal)! as CVarArg)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saleCode = getOrdersResult?.data[indexPath.row].saleCode
print(saleCode)
        performSegue(withIdentifier: "getOrder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "getOrder"?:
                let viewController = segue.destination as! GetOrderViewController
                viewController.data = saleCode!
print(saleCode)
            default: break
            
        }
    }
}
