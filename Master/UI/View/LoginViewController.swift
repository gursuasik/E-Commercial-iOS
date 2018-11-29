//
//  LoginViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 14.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    
    var indicator: NVActivityIndicatorView!
    
///////////////////////////////////////////
var homePageResultTest: HomeViewController?
///////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        self.email.delegate = self //For hide keyboard
        self.password.delegate = self //For hide keyboard
    }

    override func viewWillAppear(_ animated: Bool) {
        if registerResult != nil {
            getToken(username: (registerResult?.data?.email)!, password: (registerResult?.data?.password)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func login(_ sender: Any) {
        getToken(username: email.text!, password: password.text!)
    }
    
    func getToken(username: String, password: String) {
        let request = TokenRequest(username: username, password: password)
        
        /*Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseJSON { response in
            self.indicator.stopAnimating()

            print(response)
        }*/
        Alamofire.request(request.url(), method: request.method, parameters: request.parameters()).responseTokenResult { (response: DataResponse<TokenResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                if let result = response.result.value {
                    tokenResult = result
                    
                    DBHelper().insertToken(tokenRequest: request)

                    emailAddress = self.email.text
                    
                    openLogin = true
///////////////////////////////////////////////////////////
self.homePageResultTest?.backDataTest(data: "backDataTest")
///////////////////////////////////////////////////////////
                    self.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı veya şifre yanlış!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        
        return true
    }
}
