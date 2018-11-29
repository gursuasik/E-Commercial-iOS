//
//  GetDiscountCouponListViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 24.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class GetDiscountCouponListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var indicator: NVActivityIndicatorView!
    var getDiscountCouponList: GetDiscountCouponListResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.isNavigationBarHidden = false
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        let request = GetDiscountCouponListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!)
        indicator.startAnimating()
        print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
            self.indicator.stopAnimating()

            print(response)
        }
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetDiscountCouponListResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    self.getDiscountCouponList = response.result.value!
                
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
        if getDiscountCouponList == nil {
            return 0
        }
        
        return getDiscountCouponList!.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GetDiscountCouponListTableViewCell
        
        cell.code.text = getDiscountCouponList?.data[indexPath.row].code

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        let startDate: NSDate? = dateFormatterGet.date(from: (getDiscountCouponList?.data[indexPath.row].startDate)!) as! NSDate
        cell.startDate.text = dateFormatterPrint.string(from: startDate! as Date)
        
        let endDate: NSDate? = dateFormatterGet.date(from: (getDiscountCouponList?.data[indexPath.row].endDate)!) as! NSDate
        cell.endDate.text = dateFormatterPrint.string(from: endDate! as Date)
        
        cell.discountPrice.text = String(format: "%.2f TL", (getDiscountCouponList?.data[indexPath.row].discountPrice)! as CVarArg)
        
        cell.isValid.text = "Geçersiz"
        if (getDiscountCouponList?.data[indexPath.row].isValid)! {
            cell.isValid.text = "Geçerli"
            cell.isValid.textColor = UIColor(red: 40 / 255, green: 211 / 255, blue: 108 / 255, alpha: 255 / 255)
        }
        
        return cell
    }
}
