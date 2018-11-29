//
//  ProductsViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 2.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate, UITextFieldDelegate {
    @IBOutlet weak var searchText: LoginTextField!
    @IBOutlet weak var productTableView: UITableView!

    var Url: String?
    var s = ""
    var o = ""
    var k = ""
    var t = ""
    var indicator: NVActivityIndicatorView!
    var searchResult: SearchResult?
    var productCode:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        self.searchText.delegate = self//For hide keyboard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if openLogin! {
            if open == "Account" {
                open == ""
                
                let storyboard = UIStoryboard(name: "Account", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "account") as! AccountViewController
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            else if open == "Basket" {
                open == ""
                
                let storyboard = UIStoryboard(name: "Basket", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "basketId") as! BasketViewController
                //viewController.addProductRequest = addProductRequest
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            
            openLogin = false
        }
        else {
            search()
        }
    }
    
    @IBAction func search(_ sender: Any) {
        /*let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar*/
        if searchText.text?.count != 0 {
            Url = ""
            k = searchText.text!
            search()
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func showBasket(_ sender: Any) {
        if tokenResult != nil {
            let storyboard = UIStoryboard(name: "Basket", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "basketId") as! BasketViewController
            //viewController.addProductRequest = addProductRequest
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else {
            open = "Basket"
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searchResult?.data.products.count == nil {
            return 0
        }
        return (searchResult?.data.products.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductsTableViewCell
        
        cell.productName.text = searchResult?.data.products[indexPath.row].name
        cell.productPrice.text = String(format: "%.2f TL", (searchResult?.data.products[indexPath.row].price)!)
        
        let indicator = NVActivityIndicatorView(frame: CGRect(x: (cell.center.x - 45), y: (cell.center.y - 45), width: 40, height: 40))
        indicator.type = .ballRotateChase
        indicator.color = UIColor.black
        cell.addSubview(indicator)
        
        indicator.startAnimating()
        
        Alamofire.request(Config().PRODUCT_IMAGE_URL + (searchResult?.data.products[indexPath.row].imageList[0])!).responseData { response in
            indicator.stopAnimating()
            
            if let data = response.data {
                cell.productImage.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productCode = searchResult?.data.products[indexPath.row].productCode

        performSegue(withIdentifier: "productDescription", sender: self)
        
        /*let viewController = ProductDescriptionViewController()
        viewController.productCode = productCode
        navigationController?.pushViewController(viewController, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, indexPath: IndexPath) {
        //performSegue(withIdentifier: "userMenu", sender: self)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
            case 0:
                /*let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()! as! BaseViewController
                self.present(viewController, animated: true, completion: nil)
            */
                dismiss(animated: true, completion: nil)
            
            case 1:
                print("Favorilerim")
            
            case 2:
                /*let storyboard = UIStoryboard(name: "Account", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "account") as! AccountViewController
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)*/
                if tokenResult != nil {
                    let storyboard = UIStoryboard(name: "Account", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "account") as! AccountViewController
                    let navigationController = UINavigationController(rootViewController: viewController)
                    self.present(navigationController, animated: true, completion: nil)
                }
                else {
                    open = "Account"
                    
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginViewController
                    let navigationController = UINavigationController(rootViewController: viewController)
                    self.present(navigationController, animated: true, completion: nil)
            }
            
            default:
                print("Default")
        }
    }
    
    func search() {
        indicator.startAnimating()
        let request = SearchRequest(Url: Url!, p: "1", ps: "20", s: s, o: o, k: k, t: t)
        print(request.parameters())
        /*Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseJSON { response in
            self.indicator.stopAnimating()
            
            print(response)
        }*/
        Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseSearchResult { (response: DataResponse<SearchResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                if let result = response.result.value {
                    self.searchResult = result
                    
                    self.productTableView.reloadData()
                    
                    /*let group = DispatchGroup()
                     
                     for slider in (homePage?.data.slider)! {
                     group.enter()
                     
                     Alamofire.request(slider.smallImage).responseData { response in
                     if let data = response.data {
                     featureArray.append(["image": data])
                     
                     print(slider.smallImage)
                     
                     group.leave()
                     }
                     }
                     }
                     
                     group.notify(queue: .main) {
                     print("Home Page: OK")
                     
                     self.performSegue(withIdentifier: "sideMenu", sender: self)
                     }*/
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
        searchText.resignFirstResponder()
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "productDescription"?:
                let viewController = segue.destination as! ProductDescriptionViewController
                viewController.productCode = productCode
            
            case "filter"?:
                let viewController = segue.destination as! FilterViewController
                viewController.searchResult = searchResult
            
            default: break
        }
    }
}
