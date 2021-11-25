//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 20/11/2021.
//

import Foundation

class FakeResponseData {
    //MARK: Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    //faire une réponse KO code 500
    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    //MARK: Data
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let weatherIncorrectData = "Error" .data(using: .utf8)!

    //translate correct incorrect
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslatedText", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let translationIncorrectData = "Error" .data(using: .utf8)!
    
    static var languageCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Languages", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let languagesIncorrectData = "Error" .data(using: .utf8)!
    
    //cash correct incorrect
    static var currencySymbolsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Symbols", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let currencySymbolsIncorrectData = "Error" .data(using: .utf8)!
    
    
    static var currencyValueCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Latest", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let currencyValueincorrectData = "Error" .data(using: .utf8)!
}
