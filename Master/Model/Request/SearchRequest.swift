//
//  SearchResult.swift
//  Master
//
//  Created by Gürsu Aşık on 2.08.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import Foundation
import Alamofire

class SearchRequest {
    var endPoint = "/search"
    var method: HTTPMethod = .post
    
    var Url:String = ""
    var p:String = ""
    var ps:String = ""
    var s:String = ""
    var o:String = ""
    var k:String = ""
    var t:String = ""
    
    init(Url:String, p:String, ps:String, s:String, o:String, k:String, t:String) {
        self.Url = Url
        self.p = p
        self.ps = ps
        self.s = s
        self.o = o
        self.k = k
        self.t = t
    }
    
    func getURL() -> String {
        return Config().URL + Config().API + Config().CATALOG + endPoint
    }
    
    func parameters() -> [String: Any] {
        var arr = [String: Any]()
        
        arr[RequestApi.Url] = Url
        arr[RequestApi.p] = p
        arr[RequestApi.ps] = ps
        arr[RequestApi.s] = s
        arr[RequestApi.o] = o
        arr[RequestApi.k] = k
        arr[RequestApi.t] = t
        
        return arr
    }
}
