//
//  GetPaymentViewerResult.swift
//  Master
//
//  Created by Gürsu Aşık on 3.09.2018.
//  Copyright © 2018 RND. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let getPaymentViewerResult = try? newJSONDecoder().decode(GetPaymentViewerResult.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGetPaymentViewerResult { response in
//     if let getPaymentViewerResult = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class GetPaymentViewerResult: Codable {
    let success: Bool
    let message: String
    let data: GetPaymentViewerData
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
    
    init(success: Bool, message: String, data: GetPaymentViewerData) {
        self.success = success
        self.message = message
        self.data = data
    }
}

class GetPaymentViewerData: Codable {
    let grandTotal, bkmGrandTotal, transferGrandTotal, paypalGrandTotal: Double
    let payDoorGrandTotal: Double
    let creditCardBankList: [GetPaymentViewerCreditCardBankList]
    
    enum CodingKeys: String, CodingKey {
        case grandTotal = "GrandTotal"
        case bkmGrandTotal = "BKMGrandTotal"
        case transferGrandTotal = "TransferGrandTotal"
        case paypalGrandTotal = "PaypalGrandTotal"
        case payDoorGrandTotal = "PayDoorGrandTotal"
        case creditCardBankList = "CreditCardBankList"
    }
    
    init(grandTotal: Double, bkmGrandTotal: Double, transferGrandTotal: Double, paypalGrandTotal: Double, payDoorGrandTotal: Double, creditCardBankList: [GetPaymentViewerCreditCardBankList]) {
        self.grandTotal = grandTotal
        self.bkmGrandTotal = bkmGrandTotal
        self.transferGrandTotal = transferGrandTotal
        self.paypalGrandTotal = paypalGrandTotal
        self.payDoorGrandTotal = payDoorGrandTotal
        self.creditCardBankList = creditCardBankList
    }
}

class GetPaymentViewerCreditCardBankList: Codable {
    let id: Int
    let name, image, integrationBankCode, bankInstallmentColorCode: String
    let bankInstallmentFontColor: String
    let totalInstallmentCount: Int
    let installmentList: [GetPaymentViewerInstallmentList]
    let grandTotal: Double
    let specID: Int
    let successURL: String
    let isNormalPay, is3DPay: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case image = "Image"
        case integrationBankCode = "IntegrationBankCode"
        case bankInstallmentColorCode = "BankInstallmentColorCode"
        case bankInstallmentFontColor = "BankInstallmentFontColor"
        case totalInstallmentCount = "TotalInstallmentCount"
        case installmentList = "InstallmentList"
        case grandTotal = "GrandTotal"
        case specID = "SpecId"
        case successURL = "SuccessUrl"
        case isNormalPay = "IsNormalPay"
        case is3DPay = "Is3DPay"
    }
    
    init(id: Int, name: String, image: String, integrationBankCode: String, bankInstallmentColorCode: String, bankInstallmentFontColor: String, totalInstallmentCount: Int, installmentList: [GetPaymentViewerInstallmentList], grandTotal: Double, specID: Int, successURL: String, isNormalPay: Bool, is3DPay: Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.integrationBankCode = integrationBankCode
        self.bankInstallmentColorCode = bankInstallmentColorCode
        self.bankInstallmentFontColor = bankInstallmentFontColor
        self.totalInstallmentCount = totalInstallmentCount
        self.installmentList = installmentList
        self.grandTotal = grandTotal
        self.specID = specID
        self.successURL = successURL
        self.isNormalPay = isNormalPay
        self.is3DPay = is3DPay
    }
}

class GetPaymentViewerInstallmentList: Codable {
    let id, installment: Int
    let description: String
    let installmentPrice, grandTotal: Double
    let specID: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case installment = "Installment"
        case description = "Description"
        case installmentPrice = "InstallmentPrice"
        case grandTotal = "GrandTotal"
        case specID = "SpecId"
    }
    
    init(id: Int, installment: Int, description: String, installmentPrice: Double, grandTotal: Double, specID: Int) {
        self.id = id
        self.installment = installment
        self.description = description
        self.installmentPrice = installmentPrice
        self.grandTotal = grandTotal
        self.specID = specID
    }
}

func GetPaymentViewerNewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func GetPaymentViewerNewJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try GetPaymentViewerNewJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGetPaymentViewerResult(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GetPaymentViewerResult>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
