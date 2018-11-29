//
//  PaymentResultViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 4.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class PaymentResultViewController: UIViewController {
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var price: UILabel!

    var cardPaymentResult: CardPaymentResult?

    override func viewDidLoad() {
        super.viewDidLoad()

        message.text = cardPaymentResult?.message
        if (cardPaymentResult?.success)! {
            data.text = (cardPaymentResult?.data)! + "'nolu siparişiniz oluşturulmuştur!"
            message.textColor = UIColor(red: 40 / 255, green: 211 / 255, blue: 108 / 255, alpha: 255 / 255)
        }

        price.text = String(format: "%.2f TL", (getOrderBasketResult?.data.grandTotal)! as CVarArg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func closeBasket(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
