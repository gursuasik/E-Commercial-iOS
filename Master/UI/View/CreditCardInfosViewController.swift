//
//  CreditCardInfosViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class CreditCardInfosViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardOwner: LoginTextField!
    @IBOutlet weak var cardNumber: LoginTextField!
    @IBOutlet weak var expirationMonth: LoginTextField!
    @IBOutlet weak var expireYear: LoginTextField!
    @IBOutlet weak var cvv: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardOwner.delegate = self //For hide keyboard
        self.cardNumber.delegate = self //For hide keyboard
        self.expirationMonth.delegate = self //For hide keyboard
        self.expireYear.delegate = self //For hide keyboard
        self.cvv.delegate = self //For hide keyboard
        
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

    @IBAction func next(_ sender: Any) {
        if (cardOwner.text?.isEmpty)! {
            showAlert(message: "Kart sahibini giriniz!")
        }
        else if (cardNumber.text?.isEmpty)! {
            showAlert(message: "Kart numarasını giriniz!")
        }
        else if (expirationMonth.text?.isEmpty)! {
            showAlert(message: "Son kullanma tarihinin ay bilgisini giriniz!")
        }
        else if (expireYear.text?.isEmpty)! {
            showAlert(message: "Son kullanma tarihinin yıl bilgisini giriniz!")
        }
        else if (cvv.text?.isEmpty)! {
            showAlert(message: "CVV kodunu giriniz!")
        }
        else if cardNumber.text?.characters.count != 16 {
            showAlert(message: "Kart numarasını doğru giriniz!")
        }
        else {
            cardPaymentRequest = CardPaymentRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, email: emailAddress!, name: cardOwner.text!, cardNo: cardNumber.text!, expireMonth: expirationMonth.text!, expireYear: expireYear.text!, cvv2: cvv.text!, ip: "123.234.222.111", installmentCount: 0)
            
            performSegue(withIdentifier: "installments", sender: self)
        }
    }
    
    func showAlert(message:String) {
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
        cardOwner.resignFirstResponder()
        cardNumber.resignFirstResponder()
        expirationMonth.resignFirstResponder()
        expireYear.resignFirstResponder()
        cvv.resignFirstResponder()
        
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
        cardOwner.resignFirstResponder()
        cardNumber.resignFirstResponder()
        expirationMonth.resignFirstResponder()
        expireYear.resignFirstResponder()
        cvv.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "installments") {
            let viewController = segue.destination as! InstallmentsViewController
            viewController.data = cardNumber.text!
        }
    }
}
