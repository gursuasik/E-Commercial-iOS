//
//  SignupViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 15.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class SignupViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: LoginTextField!
    @IBOutlet weak var lastName: LoginTextField!
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    @IBOutlet weak var gender: DropDownButton!    
    
    var indicator: NVActivityIndicatorView!
    var news = "false"
    var licenceAgrement = "false"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.firstName.delegate = self //For hide keyboard
        self.lastName.delegate = self //For hide keyboard
        self.email.delegate = self //For hide keyboard
        self.password.delegate = self //For hide keyboard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newsCheck(_ sender: CheckButton) {
        sender.isSelected = !sender.isSelected
        news = "false"
        if sender.isSelected {
            news = "true"
        }
    }
    
    @IBAction func licenceAgrementCheck(_ sender: CheckButton) {
        sender.isSelected = !sender.isSelected
        licenceAgrement = "false"
        if sender.isSelected {
            licenceAgrement = "true"
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if licenceAgrement == "false"  {
            let alert = UIAlertController(title: "Hata", message: "Lütfen kullanıcı söxleşmesini onaylayınız!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            register()
        }
    }
    
    func register() {
        let request = RegisterRequest(name: firstName.text!, surname: lastName.text!, email: email.text!, password: password.text!, gender: gender.currentTitle!, birthDay: "", mobile: "", wantsNewsletter: news, isValid: licenceAgrement, iWantCard: "false")
        indicator.startAnimating()
        print(request.parameters())
        /*Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseRegisterResult { (response: DataResponse<RegisterResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                if let result = response.result.value {
                    registerResult = result
                    
                    if (registerResult?.success)! {
                        let alert = UIAlertController(title: "Tebrikler", message: "Mailiniz başarılı bir şekilde oluşturuldu!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: { action in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Dikkat", message: registerResult?.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Dikkat", message: "E-mail formatı hatalı", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Anladım", style: UIAlertActionStyle.default, handler: nil))
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
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        
        return true
    }
}
