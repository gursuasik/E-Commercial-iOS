//
//  BaseViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 30.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

var homePage: HomePageResult?
var slideHomeData = [Dictionary<String, Data>]()
var registerResult: RegisterResult?
var emailAddress: String?
var tokenResult: TokenResult?
var getOrderBasketResult: GetOrderBasketResult?
var getAddressListResult: GetAddressListResult?
var selectAddressIndex: Int?
var fastDeliverys = [FastDelivery]()
var selectFastDeliveryIndex: Int?
var paymentTypeData = [PaymentTypesCell]()
var selectPaymentTypeIndex: Int?
var getPaymentViewerResult: GetPaymentViewerResult?
var cardPaymentRequest: CardPaymentRequest?
var openLogin: Bool?
var open: String?

class BaseViewController: UIViewController {
    var indicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        //indicator.type = .ballClipRotate
        //indicator.type = .lineScale
        //indicator.type = .ballScaleMultiple
        //indicator.type = .ballScaleRippleMultiple
        //indicator.type = .ballSpinFadeLoader
        //indicator.type = .lineSpinFadeLoader
        //indicator.type = .ballRotateChase
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        slideHomeData.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let request = DBHelper().selectUser()
        if request != nil {
            print("Login: OK")
            indicator.startAnimating()
            Alamofire.request((request?.url())!, method: (request?.method)!, parameters: request?.parameters()).responseTokenResult { (response: DataResponse<TokenResult>) in
                self.indicator.stopAnimating()
                
                switch response.result {
                    case .success(let json):
                        if let result = response.result.value {
                            tokenResult = result
                            
                            emailAddress = request?.username
                            
                            self.getHomePage()
                        }
                    
                    case .failure(let error):
                        self.getHomePage()
                }
            }
        }
        else {
            print("Login: NO")
            getHomePage()
        }
    }
    
    func getHomePage() {
        indicator.startAnimating()
        let request = HomePageRequest()
        /*print(request.getParameters())
         Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(), method: request.method).responseHomePageResult { (response: DataResponse<HomePageResult>) in
            switch response.result {
                case .success(let json):
                    if let homePageResult = response.result.value {
                        homePage = homePageResult
                        
                        let group = DispatchGroup()
                        
                        for slider in (homePage?.data.slider)! {
                            group.enter()
                            
                            Alamofire.request(slider.smallImage).responseData { response in
                                if let data = response.data {
                                    slideHomeData.append(["image": data])
                                    
                                    group.leave()
                                }
                            }
                        }
                        
                        group.notify(queue: .main) {
                            self.indicator.stopAnimating()
                            
                            self.performSegue(withIdentifier: "sideMenu", sender: self)
                        }
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
    }
}
