//
//  AccountViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 6.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var tableData = [Account?]()
    var openLogin: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.isTranslucent = true
         navigationController?.navigationBar.backgroundColor = .clear
         */
        /*
         navigationItem.title = "Home"
         navigationController?.navigationBar.isTranslucent = false
         let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
         titleLabel.text = "Home"
         titleLabel.textColor = UIColor.red
         navigationItem.titleView = titleLabel
         */
        
        //navBar.isHidden = true
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = .clear

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Hoş Geldin!"
        titleLabel.textColor = UIColor.white
        navItem.titleView = titleLabel
        
        tableData = [Account(image: "detail", name: "Bilgilerim"), Account(image: "address-1", name: "Adreslerim"), Account(image: "package1", name: "Siparişlerim"), Account(image: "heart2", name: "Favorilerim"), Account(image: "tag", name: "Kuponlarım")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        /*
        if tokenResult != nil {
            print("Login: OK")
        }
        else if openLogin! {
            openLogin = false
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else {
            dismiss(animated: true, completion: nil)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signOut(_ sender: Any) {
        DBHelper().deleteUser()
        
        tokenResult = nil
        
        openLogin = false
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountTableViewCell
            
        cell.imageName.image = UIImage(named: (tableData[indexPath.row]?.image)!)
        cell.name.text = tableData[indexPath.row]?.name
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "updateContact", sender: self)
            
            case 1:
                performSegue(withIdentifier: "addressTypes", sender: self)
            
            case 2:
                performSegue(withIdentifier: "getOrders", sender: self)
            
            case 4:
                performSegue(withIdentifier: "getDiscountCouponList", sender: self)
            
            default:
                print("Default")
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            dismiss(animated: true, completion: nil)
            
        case 1:
            print("Favorilerim")
            
        case 2:
            print("Hesabım")
            
        default:
            print("Default")
        }
    }
}

class Account {
    let image: String
    let name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
