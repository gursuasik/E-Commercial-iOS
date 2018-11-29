//
//  Config.swift
//  Master
//
//  Created by Gürsu Aşık on 26.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class Config {
    //let URL:String = "http://testmsbrandroom.iyimarkalar.com"
    let URL: String = "https://mstwist.iyimarkalar.com"
    //let URL: String = "http://testmstwist.iyimarkalar.com"
    
    let PRODUCT_IMAGE_URL = "https://st-twist.mncdn.com/twist/Content/media/ProductImg/original/"
    
    let API:String = "/api"
    
    let PAGE:String = "/page"
    let HOMEPAGE:String = "/homepage"
    
    let CATALOG = "/catalog"
    let SEARCH = "/search"
    
    let PRODUCT = "/product"
    
    let CONTACT = "/contact"
    
    let GETCITYLIST = "/GetCityList"
    
    let ORDER = "/order"
    
    let ADDRESS = "/Address"
    
    let VARIABLES = "/variables"
    
    let DISCOUNTCOUPON = "/discountcoupon"
    
    let MEMBER = "/member"
    //homepage
    func homepage() -> String {
        return URL + API + PAGE + HOMEPAGE
    }
    
    func GetCityList() -> String {
        return URL + API + ADDRESS + GETCITYLIST
    }
}
