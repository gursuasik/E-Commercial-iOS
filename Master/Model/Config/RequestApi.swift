//
//  SerializationKeys.swift
//  Master
//
//  Created by Gürsu Aşık on 26.07.2018.
//  Copyright © 2018 RND. All rights reserved.
//

import UIKit

class RequestApi {
    //search
    static let Url = "Url"
    static let p = "p"
    static let ps = "ps"
    static let s = "s"
    static let o = "o"
    static let k = "k"
    static let t = "t"
    
    //GetProductDescription
    static let ProductCode = "ProductCode"
    
    //register
    static let Name = "Name"
    static let Surname = "Surname"
    static let Email = "Email"
    static let Password = "Password"
    static let Gender = "Gender"
    static let BirthDay = "BirthDay"
    static let Mobile = "Mobile"
    static let WantsNewsletter = "WantsNewsletter"
    static let IsValid = "IsValid"
    static let IWantCard = "IWantCard"
    
    //token
    static let grand_type = "grant_type"
    static let username = "username"
    static let password = "password"
    
    //addproduct
    static let Barcode = "Barcode"
    static let IsUpdate = "IsUpdate"
    static let IsAddedBySnapBuy = "IsAddedBySnapBuy"
    static let Quantity = "Quantity"
    
    //Authorization
    static let Authorization = "Authorization"
    
    //deleteproduct
    static let Data = "Data"
    
    //GetAddressList
    static let type = "Type"
    
    //SetOrderAddress
    static let isFastDelivery = "IsFastDelivery"
    static let invoiceId = "InvoiceId"
    static let useDelivery = "UseDelivery"
    
    //CardPayment
    static let CreditCard = "CreditCard"
    static let CardNo = "CardNo"
    static let ExpireMonth = "ExpireMonth"
    static let ExpireYear = "ExpireYear"
    static let Cvv2 = "Cvv2"
    static let Ip = "Ip"
    static let InstallmentCount = "InstallmentCount"
    
    //GetCityList
    static let CountryId = "CountryId"
    
    //GetTownList
    static let CityId = "CityId"
    
    //SaveAddress
    static let ContactId = "ContactId"
    static let NickName = "NickName"
    static let CityName = "CityName"
    static let TownId = "TownId"
    static let TownName = "TownName"
    static let AreaId = "AreaId"
    static let ApartmentNo = "ApartmentNo"
    static let NearestArea = "NearestArea"
    static let AddressText = "AddressText"
    static let Phone = "Phone"
    static let TaxNo = "TaxNo"
    static let TaxOffice = "TaxOffice"
    static let Id = "Id"
    static let IdentityNumber = "IdentityNumber"
    
    ///updatecontact
    static let UniqNo = "UniqNo"
    static let WorkingStatus = "WorkingStatus"
}
