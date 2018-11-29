//
//  ProductDescriptionViewController.swift
//  Master
//
//  Created by Gürsu Aşık on 6.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}

class ProductDescriptionViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgSlide: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var bodyCountView: BodyCountView!
    @IBOutlet weak var table: UITableView!
    
    var indicator: NVActivityIndicatorView!
    var getProductDescriptionResult: GetProductDescriptionResult?
    var productCode: String?
    var slides:[SlideView] = [];
    var bodySelectIndex = Int()
    var bodyData: [Body] = []
    var randomTexts: [String] = []
    var selectProduct: SelectProduct?
    var addProductStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: (self.view.center.x - 20), y: (self.view.center.y - 20), width: 40, height: 40))
        indicator.type = .circleStrokeSpin
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        
        bodyCountView.isHidden = true
        bodyCountView.body.addTarget(self, action: #selector(bodyCountClose), for: UIControlEvents.touchUpInside)
        bodyCountView.reduce.addTarget(self, action: #selector(bodyCountReduce), for: UIControlEvents.touchUpInside)
        bodyCountView.increment.addTarget(self, action: #selector(bodyCountIncrement), for: UIControlEvents.touchUpInside)
        
        bodyCollectionView.register(UINib.init(nibName: "BodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BodyCollectionViewCell")
        /*if let bodyFlowLayout = bodyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            bodyFlowLayout.estimatedItemSize = CGSize(width: 2, height: 2)
        }*/
        bodyCollectionView.dataSource = self
        
        let request = GetProductDescriptionRequest(productCode: productCode!)
        indicator.startAnimating()
        print(request.parameters())
        /*Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseJSON { response in
            self.indicator.stopAnimating()
         
            print(response)
        }*/
        Alamofire.request(request.getURL(), method: request.method, parameters: request.parameters()).responseGetProductDescriptionResult { (response: DataResponse<GetProductDescriptionResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
                case .success(let json):
                    if let result = response.result.value {
                        self.getProductDescriptionResult = result
                        
                        let group = DispatchGroup()
                        
                        for image in (self.getProductDescriptionResult?.data.images)! {
                            group.enter()
                            
                            Alamofire.request(Config().PRODUCT_IMAGE_URL + image.fileName).responseData { response in
                                if let data = response.data {
                                    let slide:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
                                    slide.productDescriptionImage.image = UIImage(data: data)
                                    self.slides.append(slide)
                                    
                                    group.leave()
                                }
                            }
                        }
                        
                        group.notify(queue: .main) {
                            self.setupSlideScrollView(slides: self.slides)
                        }
                        
                        self.name.text = self.getProductDescriptionResult?.data.name
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: String(format: "%.2f TL", (self.getProductDescriptionResult?.data.oldPrice)! as CVarArg))
                        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                        self.oldPrice.attributedText = attributeString
                        self.price.text = String(format: "%.2f TL", (self.getProductDescriptionResult?.data.price)! as CVarArg)
                        
                        let m: Int = (self.getProductDescriptionResult?.data.products.count)!
                        for i in 0..<m {
                            let body = Body()
                            body.name = (self.getProductDescriptionResult?.data.products[i].body)!
                            self.bodyData.append(body)
                        }
                        self.bodyCollectionView.reloadData()
                        
                        var explaination1: String = ""
                        if self.getProductDescriptionResult?.data.reference3 != nil {
                            explaination1 = (self.getProductDescriptionResult?.data.reference3)!
                        }
                        if self.getProductDescriptionResult?.data.explaination != nil {
                            explaination1 += "<br>" + (self.getProductDescriptionResult?.data.explaination)!
                        }
                        if explaination1 != "" {
                            self.randomTexts.append(explaination1)
                        }
                        
                        var explaination2: String = ""
                        if self.getProductDescriptionResult?.data.secondExplaination != nil {
                            explaination2 = (self.getProductDescriptionResult?.data.secondExplaination)!
                        }
                        if self.getProductDescriptionResult?.data.fourthExplaination != nil {
                            explaination2 += "<br>" + (self.getProductDescriptionResult?.data.fourthExplaination)!
                        }
                        if explaination2 != "" {
                            self.randomTexts.append(explaination2)
                        }
                        
                        /*self.randomTexts = [(self.getProductDescriptionResult?.data.reference3)! + "<br>" + (self.getProductDescriptionResult?.data.explaination)! + "<br>" + (self.getProductDescriptionResult?.data.thirdExplaination)!,
                                            (self.getProductDescriptionResult?.data.secondExplaination)! + "<br>" + (self.getProductDescriptionResult?.data.fourthExplaination)!]
                        */
                        self.table.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if tokenResult != nil && addProductStatus {
            addProduct()
        }
        
        if openLogin! {
            if open == "Basket" {
                open == ""
                
                let storyboard = UIStoryboard(name: "Basket", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "basketId") as! BasketViewController
                //viewController.addProductRequest = addProductRequest
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            
            openLogin = false
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomTexts.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductDescriptionTableViewCell
        
        cell.headerLabel.text = "Ürün Açıklaması"
        if indexPath.row == 1 {
            cell.headerLabel.text = "Diğer Özellikler"
        }
        cell.descriptionLabel.attributedText = (randomTexts[indexPath.row]).convertHtml()

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bodyCollectionView {
            return bodyData.count;
        }
        else {
            return randomTexts.count;
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bodyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyCollectionViewCell", for: indexPath) as! BodyCollectionViewCell
            
            /*cell.bodyLabel.text = String(indexPath.row)
            cell.bodyLabel.sizeToFit()
            */
            
            cell.bodyButton.setTitle(bodyData[indexPath.row].name, for: UIControlState.normal)
            cell.bodyButton.tag = indexPath.row
            cell.bodyButton.addTarget(self, action: #selector(bodyCountOpen), for: UIControlEvents.touchUpInside)

            //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width + 50, height: cell.frame.size.height)
            //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: 200 / 2, height: cell.frame.size.height)
            cell.frame = CGRect(x: CGFloat((Int(bodyCollectionView.bounds.width) / bodyData.count) * indexPath.row), y: cell.frame.origin.y, width: bodyCollectionView.bounds.width / CGFloat(bodyData.count), height: cell.frame.size.height)

            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            
            cell.headerLabel.text = "Ürün Açıklaması"
            if indexPath.row == 1 {
                cell.headerLabel.text = "Diğer Özellikler"
            }
            cell.descriptionLabel.attributedText = (randomTexts[indexPath.row]).convertHtml()
            
            //cell.frame = CGRect(x: CGFloat((Int(collectionView.bounds.width) / 2) * indexPath.row), y: cell.frame.origin.y, width: collectionView.bounds.width / CGFloat(2), height: cell.frame.size.height)
            
            cell.frame = CGRect(x: cell.frame.origin.x, y: CGFloat(Int(collectionView.frame.height) * indexPath.row), width: collectionView.bounds.width, height: 400)
            
            return cell
        }
    }

    func bodyCountOpen(sender: UIButton) {
        for i in 0..<bodyData.count {
            bodyData[i].select = 0
        }
        
        bodySelectIndex = sender.tag

        bodyData[bodySelectIndex].select = 1

        selectProduct = SelectProduct(barcode: (getProductDescriptionResult?.data.products[bodySelectIndex].barcode)!, isUpdate: "false", isAddedBySnapBuy: false, quantity: String(bodyData[bodySelectIndex].select))
        
        bodyCountView.body.setTitle(bodyData[bodySelectIndex].name, for: UIControlState.normal)
        bodyCountView.count.text = "1"

        bodyCountView.isHidden = false
    }

    func bodyCountClose(sender: UIButton) {
        bodyCountView.isHidden = true
    }

    func bodyCountReduce(sender: UIButton) {
        if bodyData[bodySelectIndex].select > 0 {
            bodyData[bodySelectIndex].select -= 1
        }

        selectProduct?.quantity = String(bodyData[bodySelectIndex].select)
        
        bodyCountView.count.text = String(bodyData[bodySelectIndex].select)
    }

    func bodyCountIncrement(sender: UIButton) {
        bodyData[bodySelectIndex].select += 1

        selectProduct?.quantity = String(bodyData[bodySelectIndex].select)
        
        bodyCountView.count.text = String(bodyData[bodySelectIndex].select)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CollectionView Selected")
        /*let url = thumbnailFileURLS[indexPath.item]
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupSlideScrollView(slides: [SlideView]) {
        self.imgSlide.delegate = self
        imgSlide.isPagingEnabled = true
        imgSlide.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imgSlide.contentSize = CGSize(width: self.view.bounds.width * CGFloat(slides.count), height: self.view.bounds.size.width)
        imgSlide.showsHorizontalScrollIndicator = false
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            imgSlide.addSubview(slides[i])
        }

        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //let pageIndex = round(imgSlide.contentOffset.x/view.frame.width)
        //pageControl.currentPage = Int(pageIndex)
        
        let page = imgSlide.contentOffset.x / imgSlide.frame.size.width
        pageControl.currentPage = Int(page)
        /*let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            slides[0].productDescriptionImg.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].productDescriptionImg.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        }
        else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].productDescriptionImg.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].productDescriptionImg.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
        }
        else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].productDescriptionImg.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].productDescriptionImg.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
        }
        else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].productDescriptionImg.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].productDescriptionImg.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }*/
    }

    @IBAction func addBasket(_ sender: Any) {
        if selectProduct != nil {
            if tokenResult == nil {
                addProductStatus = true
                open = ""
                
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginViewController
                //viewController.addProductRequest = addProductRequest
                let navigationController = UINavigationController(rootViewController: viewController)
                self.present(navigationController, animated: true, completion: nil)
                
                /*
                 let storyboard =  UIStoryboard(name: "Login", bundle: nil)
                 let vc = storyboard.instantiateInitialViewController() as UIViewController!
                 navigationController?.pushViewController(vc!, animated: true)
                 */
            }
            else {
                addProduct()
            }
        }
        else {
            let alert = UIAlertController(title: "Dikkat", message: "Önce beden seçiniz!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func addProduct() {
        let request = AddProductRequest(token_type: (tokenResult?.tokenType)!, authorization: (tokenResult?.accessToken)!, barcode: (selectProduct?.barcode)!, isUpdate: (selectProduct?.isUpdate)!, isAddedBySnapBuy: (selectProduct?.isAddedBySnapBuy)!, quantity: (selectProduct?.quantity)!)
        indicator.startAnimating()
        
        Alamofire.request(request.getURL(), method: request.method, parameters: request.getParameters(), encoding: JSONEncoding.default, headers: request.getHeaders()).responseAddProductResult { (response: DataResponse<AddProductResult>) in
            self.indicator.stopAnimating()
            
            switch response.result {
            case .success(let json):
                if let result = response.result.value {
                    if result.success {
                        self.addProductStatus = false
                        
                        let alert = UIAlertController(title: "Tebrikler", message: "Ürün sepete eklendi!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Dikkat", message: result.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

class SelectProduct {
    var barcode: String
    var isUpdate: String
    var isAddedBySnapBuy: Bool
    var quantity: String
    
    init(barcode: String, isUpdate: String, isAddedBySnapBuy: Bool, quantity: String) {
        self.barcode = barcode
        self.isUpdate = isUpdate
        self.isAddedBySnapBuy = isAddedBySnapBuy
        self.quantity = quantity
    }
}
