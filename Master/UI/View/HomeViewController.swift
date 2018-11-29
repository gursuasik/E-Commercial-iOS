//
//  ViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 26.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var featureScrollView: UIScrollView!
    @IBOutlet weak var featurePageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openLogin = false
        open = ""
        
        sideMenus()
        customizeNavBar()
        
        featureScrollView.delegate = self
        featureScrollView.isPagingEnabled = true
        featureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(slideHomeData.count), height: self.view.bounds.size.width)
        featureScrollView.showsHorizontalScrollIndicator = false
        featurePageControl.numberOfPages = slideHomeData.count
        featurePageControl.currentPage = 0
        
        slideHome()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {        
        if openLogin! {
            if open == "Account" {
                let storyboard = UIStoryboard(name: "Account", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "account") as! AccountViewController
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            else if open == "Basket" {
                let storyboard = UIStoryboard(name: "Basket", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "basketId") as! BasketViewController
                //viewController.addProductRequest = addProductRequest
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            
            openLogin = false
            open == ""
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featurePageControl.currentPage = Int(page)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (homePage?.data.banner.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BannerTableViewCell
        
        Alamofire.request((homePage?.data.banner[indexPath.row].field.value)!).responseData { response in
            if let data = response.data {
                cell.imageBanner.image = UIImage(data: data)
                cell.value.text = homePage?.data.banner[indexPath.row].parentFields[0].value
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, indexPath: IndexPath) {
        //performSegue(withIdentifier: "userMenu", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func sideMenus(){
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
            //revealViewController().rearViewRevealOverdraw = 10;
            //revealViewController().toggleAnimationDuration = 0.2;
            //revealViewController().toggleAnimationType = SWRevealToggleAnimationType;
            //revealViewController().frontViewShadowRadius = 15;
        }
    }
    
    func customizeNavBar(){
        //navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255.0, green:255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        //navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:255.0/87.0, blue: 255.0/35.0, alpha: 1.0)
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func slideHome() {
        for (index, feature) in slideHomeData.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("FeatureView", owner: self, options: nil)?.first as? FeatureView {
                featureView.image.image = UIImage(data: feature["image"]!)
                featureView.title.text = homePage?.data.slider[index].title
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                featureScrollView.addSubview(featureView)
            }
        }
    }
    
    func buyFeature(sender: UIButton) {
        print("The user wants to buy feature x")
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("Ana Sayfa")
            
        case 1:
            print("Favorilerim")
            
        case 2:
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
////////////////////////////////////////
viewController.homePageResultTest = self
////////////////////////////////////////
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            
        default:
            print("Default")
        }
    }
/////////////////////////////////////
    func backDataTest(data: String) {
        print(data)
    }
/////////////////////////////////////
}
