//
//  AccountAddAddressViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 10.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import RCActionView

class AccountAddAddressViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var head: UIButton!
    @IBOutlet weak var name: LoginTextField!
    @IBOutlet weak var surname: LoginTextField!
    @IBOutlet weak var province: UIButton!
    @IBOutlet weak var district: UIButton!
    @IBOutlet weak var area: UIButton!
    @IBOutlet weak var address: LoginTextField!
    @IBOutlet weak var phone: LoginTextField!
    
    var addressType: Int?
    var indicator: NVActivityIndicatorView!
    var heads = [String]()
    var headSelect: Int?
    var provinceId: Int?
    var provinceIds = [Int]()
    var provinces = [String]()
    var districtId: Int?
    var districtIds = [Int]()
    var districts = [String]()
    var areaId: Int?
    var areaIds = [Int]()
    var areas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        head.layer.shadowColor = UIColor.darkGray.cgColor
        head.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        head.layer.shadowOpacity = 1.0
        head.layer.shadowRadius = 0.0
        
        province.layer.shadowColor = UIColor.darkGray.cgColor
        province.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        province.layer.shadowOpacity = 1.0
        province.layer.shadowRadius = 0.0
        
        district.layer.shadowColor = UIColor.darkGray.cgColor
        district.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        district.layer.shadowOpacity = 1.0
        district.layer.shadowRadius = 0.0
        
        area.layer.shadowColor = UIColor.darkGray.cgColor
        area.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        area.layer.shadowOpacity = 1.0
        area.layer.shadowRadius = 0.0
        
        heads = ["Ev Adresi", "İş Adresi", "Diğer Adres"]
        headSelect = -1
        
        let request = GetCityListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, countryId: "90")
        indicator.startAnimating()
        /*print(request.getParameters())
         Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetCityListResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    let result = response.result.value
                    
                    for item in (result?.data)! {
                        self.provinceIds.append(item.id)
                        self.provinces.append(item.name)
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
        
        name.delegate = self //For hide keyboard
        surname.delegate = self //For hide keyboard
        address.delegate = self //For hide keyboard
        phone.delegate = self //For hide keyboard
        
        ////////////
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        ////////////
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))//
        self.scrollView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func head(_ sender: Any) {
        RCActionView(style: .light).showSheetWithTitle("Başlık seçiniz", itemTitles: heads, itemSubTitles: [], selectedIndex: headSelect!, selectedHandle: { (selectedOption:Int) -> Void in
            self.headSelect = selectedOption
            self.head.setTitle(self.heads[self.headSelect!], for: .normal)
        })
    }
    
    @IBAction func province(_ sender: Any) {
        RCActionView(style: .light).showSheetWithTitle("İl seçiniz", itemTitles: provinces, itemSubTitles: [], selectedIndex: -1, selectedHandle: { (selectedOption:Int) -> Void in
            self.provinceId = self.provinceIds[selectedOption]
            self.province.setTitle(self.provinces[selectedOption], for: .normal)
            
            self.districtId = 0
            self.areaId = nil
            
            self.district.setTitle("", for: .normal)
            self.area.setTitle("", for: .normal)
            
            self.setProvince()
        })
    }

    @IBAction func district(_ sender: Any) {
        RCActionView(style: .light).showSheetWithTitle("İlçe seçiniz", itemTitles: districts, itemSubTitles: [], selectedIndex: -1, selectedHandle: { (selectedOption:Int) -> Void in
            self.districtId = self.districtIds[selectedOption]
            self.district.setTitle(self.districts[selectedOption], for: .normal)
            
            self.areaId = nil
            
            self.area.setTitle("", for: .normal)
            self.setDistrict()
        })
    }

    @IBAction func area(_ sender: Any) {
        RCActionView(style: .light).showSheetWithTitle("Semt seçiniz", itemTitles: areas, itemSubTitles: [], selectedIndex: -1, selectedHandle: { (selectedOption:Int) -> Void in
            self.areaId = self.areaIds[selectedOption]
            self.area.setTitle(self.areas[selectedOption], for: .normal)
        })
    }

    func setProvince() {
        districtIds.removeAll()
        districts.removeAll()
        
        areaIds.removeAll()
        areas.removeAll()
        
        let request = GetTownListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, cityId: provinceId!)
        indicator.startAnimating()
        /*print(request.getParameters())
         Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetTownListResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    let result = response.result.value
                    
                    for item in (result?.data)! {
                        self.districtIds.append(item.id)
                        self.districts.append(item.name)
                    }
                
                    self.setDistrict()
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    func setDistrict() {
        areaIds.removeAll()
        areas.removeAll()
        
        let request = GetAreaListRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, Data: districtId!)
        indicator.startAnimating()
        /*print(request.getParameters())
         Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
         self.indicator.stopAnimating()
         
         print(response)
         }*/
        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseGetAreaListResult { response in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                let result = response.result.value
                
                for item in (result?.data)! {
                    self.areaIds.append(item.id)
                    self.areas.append(item.name)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    /////////////////////////
    @IBAction func save(_ sender: Any) {
        if head.currentTitle == nil {
            showAlert(message: "Başlık seçiniz!")
        }
        else if (name.text?.isEmpty)! {
            showAlert(message: "Ad giriniz!")
        }
        else if (surname.text?.isEmpty)! {
            showAlert(message: "Soyad giriniz!")
        }
        else if province.currentTitle == nil {
            showAlert(message: "İli seçiniz!")
        }
        else if district.currentTitle == nil || district.currentTitle == "" {
            showAlert(message: "İlçeyi seçiniz!")
        }
        else if area.currentTitle == "" && areaIds.count != 0 {
            showAlert(message: "Semt seçiniz!")
        }
        else if (address.text?.isEmpty)! {
            showAlert(message: "Adres giriniz!")
        }
        else if (phone.text?.isEmpty)! {
            showAlert(message: "Telefon numaranızı giriniz!")
        }
        else {
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
                        //print(response.result.value?.data.segments[0].contactID)
                        
                        var areaIdString: String
                        if self.areaId == nil {
                            areaIdString = ""
                        }
                        else {
                            areaIdString = String(self.areaId!)
                        }

                        let request = SaveAddressRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, type: self.addressType!, contactId: (response.result.value?.data.segments[0].contactID)!, nickName: self.head.currentTitle!, name: self.name.text!, surname: self.surname.text!, countryId: 90, cityId: self.provinceId!, cityName: self.province.currentTitle!, townId: self.districtId!, townName: self.district.currentTitle!, areaId: areaIdString, apartmentNo: "", nearestArea: "", addressText: self.address.text!, phone: self.phone.text!, taxNo: "", taxOffice: "", id: 0, identityNumber: "")
                        self.indicator.startAnimating()
                        /*print(request.getParameters())
                        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), headers: request.getHeaders()).responseJSON { response in
                         self.indicator.stopAnimating()
                     
                         print(response)
                         }*/
                        Alamofire.request(request.getURL(),method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseSaveAddressResult { response in
                            self.indicator.stopAnimating()
                     
                            switch response.result {
                            case .success(let json):
                                let result = response.result.value
//print(result?.message)
                                if (result?.success)! {
                                    let alert = UIAlertController(title: "Tebrikler!", message: "Adres eklendi!", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { (action) in
                                        self.navigationController?.popViewController(animated: true)
                                    }))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else {
                                    let alert = UIAlertController(title: "Hata!", message: "Adres eklenmedi!", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                    
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Dikkat!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        surname.resignFirstResponder()
        address.resignFirstResponder()
        phone.resignFirstResponder()
        
        return true
    }
    
    var keyboardStatus:CGFloat = 1;
    func keyboardWillShow(_ notification:Notification) {
        adjustingHeight(notification: notification)
    }
    func keyboardWillHide(_ notification:Notification) {
        keyboardStatus = -1
        adjustingHeight(notification: notification)
        keyboardStatus = 1
    }
    func adjustingHeight(notification:Notification) {
        var userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let changeInHeight = keyboardFrame.height * keyboardStatus
        
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            if self.scrollView.contentInset.bottom != 0 {
                self.scrollView.contentInset.bottom = 0
                self.scrollView.scrollIndicatorInsets.bottom = 0
            }
            else {
                self.scrollView.contentInset.bottom += changeInHeight
                self.scrollView.scrollIndicatorInsets.bottom += changeInHeight
            }
        })
        
        keyboardStatus = 0
    }
    //Hide keyboard when user touches outside keyboard on scrollview
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        surname.resignFirstResponder()
        province.resignFirstResponder()
        address.resignFirstResponder()
        phone.resignFirstResponder()
    }
}
