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
    
    //MARK: Data
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "Error" .data(using: .utf8)!

    //translate correct incorrect
    //cash correct incorrect
}
