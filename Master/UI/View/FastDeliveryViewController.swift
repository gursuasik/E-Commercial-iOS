//
//  FastDeliveryViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class FastDeliveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var indicator: NVActivityIndicatorView!
    var areaId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        let request = FastDeliveryIdsRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!)
        fastDeliverys = [FastDelivery]()
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseFastDeliveryIDSResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    let result = response.result.value
                    if (result?.success)! {
                        fastDeliverys.append(FastDelivery(name: "Standart Teslimat", note: "Standart teslimat MNG Kargo ile 2-3 iş günü içerisinde teslim edilir."))
                        
                        let separated = result?.data.characters.split{$0 == ","}.map(String.init)
                        if separated!.contains(where: {$0 == String(describing: self.areaId!)}) {
                            fastDeliverys.append(FastDelivery(name: "Aynı Gün Teslimat", note: "11:00 öncesi siparişleriniz 18:00'a kadar teslim edilir. 11:00 sonrası siparişleriniz ertesi gün işlem görür."))
                        }

                        self.table.reloadData()
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return fastDeliverys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FastDeliveryTableViewCell
        
        cell.name.text = fastDeliverys[indexPath.row].name
        cell.note.text = fastDeliverys[indexPath.row].note
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectFastDeliveryIndex = indexPath.row
        
        performSegue(withIdentifier: "paymentTypes", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

class FastDelivery {
    let name: String
    let note: String
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
}
