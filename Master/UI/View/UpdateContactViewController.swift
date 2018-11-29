//
//  UpdateContactViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 24.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class UpdateContactViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: LoginTextField!
    @IBOutlet weak var lastName: LoginTextField!
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    @IBOutlet weak var gender: DropDownButton!
    @IBOutlet weak var newsCheck: CheckButton!
    
    var indicator: NVActivityIndicatorView!
    var contactId: Int?
    var uniqNo: String?
    var birthDay: String?
    var mobile: String?
    var news = "false"
    var isValid: String?
    var workingStatus: String?
    var identityNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.isNavigationBarHidden = false
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        //gender.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //gender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gender.dropView.dropDownOption = ["Kadın", "Erkek"]
        gender.layer.shadowColor = UIColor.darkGray.cgColor
        gender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        gender.layer.shadowOpacity = 1.0
        gender.layer.shadowRadius = 0.0
        
        let request = GetContactRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!)
        indicator.startAnimating()
        /*print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
            self.indicator.stopAnimating()

            print(response)
        }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetContactResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    let getContactResult = response.result.value

                    self.contactId = (getContactResult?.data.segments[0].contactID)!
                    self.uniqNo = (getContactResult?.data.uniqNo)!
                
                    self.firstName.text = getContactResult?.data.name
                    self.lastName.text = getContactResult?.data.surname
                    self.email.text = getContactResult?.data.email
                    self.gender.titleText = getContactResult?.data.gender
                    self.birthDay = getContactResult?.data.birthDay
                    self.mobile = getContactResult?.data.mobile
                    self.newsCheck.isSelected = (getContactResult?.data.wantsNewsletter)!
                    self.workingStatus = (getContactResult?.data.workingStatus)!
                    self.identityNumber = (getContactResult?.data.identityNumber)!
                    
                    self.password.text = DBHelper().selectUser()?.password
                    
                    self.news = "false"
                    if self.newsCheck.isSelected {
                        self.news = "true"
                    }
                
                    self.isValid = "false"
                    if (getContactResult?.data.isValid)! {
                        self.isValid = "true"
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
        
        self.firstName.delegate = self //For hide keyboard
        self.lastName.delegate = self //For hide keyboard
        self.email.delegate = self //For hide keyboard
        self.password.delegate = self //For hide keyboard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newsCheck(_ sender: CheckButton) {
        sender.isSelected = !sender.isSelected
        news = "false"
        if sender.isSelected {
            news = "true"
        }
    }
    
    @IBAction func update(_ sender: Any) {
        let request = UpdateContactRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, id: contactId!, uniqNo: uniqNo!, name: firstName.text!, surname: lastName.text!, email: email.text!, password: password.text!, gender: gender.currentTitle!, birthDay: birthDay!, mobile: mobile!, wantsNewsletter: news, isValid: isValid!, workingStatus: workingStatus!, identityNumber: identityNumber!)
        indicator.startAnimating()
        /*print(request.getParameters())
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
            self.indicator.stopAnimating()
            
            print(response)
        }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseUpdateContactResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    if (response.result.value?.success)! {
                        DBHelper().deleteUser()
                        
                        let request = TokenRequest(username: self.email.text!, password: self.password.text!)

                        Alamofire.request(request.url(), method: request.method, parameters: request.parameters()).responseTokenResult { (response: DataResponse<TokenResult>) in
                            self.indicator.stopAnimating()

                            switch response.result {
                                case .success(let json):
                                    if let result = response.result.value {
                                        tokenResult = result

                                        DBHelper().insertToken(tokenRequest: request)

                                        let alert = UIAlertController(title: "Tebrikler", message: "Profiliniz güncellendi!", preferredStyle: UIAlertControllerStyle.alert)
                                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { action in
                                            self.navigationController?.popViewController(animated: true)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                    }

                                case .failure(let error):
                                    let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı veya şifre yanlış!", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Dikkat", message: "Hata oluştu!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        
        return true
    }
}
