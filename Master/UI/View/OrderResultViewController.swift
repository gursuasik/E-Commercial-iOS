//
//  OrderResultViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class OrderResultViewController: UIViewController {
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var deliveryMessage: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressMessage: UILabel!
    @IBOutlet weak var paymentIcon: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var installment: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var indicator: NVActivityIndicatorView!
    var cardPaymentResult: CardPaymentResult?
    
    var message: String?
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        delivery.text = fastDeliverys[selectFastDeliveryIndex!].name
        deliveryMessage.text = fastDeliverys[selectFastDeliveryIndex!].note
        address.text = getAddressListResult?.data[selectAddressIndex!].nickName
        addressMessage.text = getAddressListResult?.data[selectAddressIndex!].addressText
        paymentIcon.image = UIImage(named: paymentTypeData[selectPaymentTypeIndex!].image)
        cardName.text = cardPaymentRequest?.name
        installment.text = String(describing: cardPaymentRequest?.installmentCount)
        let inst = cardPaymentRequest?.installmentCount
        installment.text = String(describing: inst!) + " Taksit"
        if cardPaymentRequest?.installmentCount == 1 {
            installment.text = "Tek Çekim"
        }
        price.text = String(format: "%.2f TL", (getOrderBasketResult?.data.grandTotal)! as CVarArg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payment(_ sender: Any) {
        /*if let addr = getWiFiAddress() {
         print(addr)
         } else {
         print("No WiFi address")
         }*/
        
        let request = CardPaymentRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, email: (cardPaymentRequest?.email)!, name: (cardPaymentRequest?.name)!, cardNo: (cardPaymentRequest?.cardNo)!, expireMonth: (cardPaymentRequest?.expireMonth)!, expireYear: (cardPaymentRequest?.expireYear)!, cvv2: (cardPaymentRequest?.cvv2)!, ip: "123.234.222.111", installmentCount: (cardPaymentRequest?.installmentCount)!)
        indicator.startAnimating()
        
        /*print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
        }*/
        
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseCardPaymentResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    self.cardPaymentResult = response.result.value
                    
                    self.message = response.result.value?.message
                    self.data = response.result.value?.data
                    
                    self.performSegue(withIdentifier: "paymentResult", sender: self)
                
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "paymentResult") {
            let viewController = segue.destination as! PaymentResultViewController
            viewController.cardPaymentResult = cardPaymentResult!
        }
    }
    
    func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}
