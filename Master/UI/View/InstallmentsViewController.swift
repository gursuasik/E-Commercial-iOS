//
//  installmentsViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class InstallmentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var indicator: NVActivityIndicatorView!
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        let request = GetPaymentViewerRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, data: data!)
        indicator.startAnimating()
        
        /*print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
        }*/
         
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetPaymentViewerResult { (response: DataResponse<GetPaymentViewerResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    getPaymentViewerResult = response.result.value

                    self.table.reloadData()
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if getPaymentViewerResult == nil {
            return 0
        }
        
        return (getPaymentViewerResult?.data.creditCardBankList[0].installmentList.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InstallmentTableViewCell

        let inst = getPaymentViewerResult?.data.creditCardBankList[0].installmentList[indexPath.row].installment
        cell.name.text = String(describing: inst!) + " Taksit"
        if getPaymentViewerResult?.data.creditCardBankList[0].installmentList[indexPath.row].installment == 1 {
            cell.name.text = "Tek Çekim"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inst = getPaymentViewerResult?.data.creditCardBankList[0].installmentList[indexPath.row].installment
        cardPaymentRequest?.installmentCount = inst!
        
        performSegue(withIdentifier: "orderResult", sender: self)
    }
}
