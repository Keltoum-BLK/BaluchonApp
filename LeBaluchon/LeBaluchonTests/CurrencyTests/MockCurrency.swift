//
//  MockCurrency.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 25/11/2021.
//

import XCTest
@testable import LeBaluchon

class MockCurrency: XCTestCase {

    var currencyService: ApiCurrencyService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        currencyService = ApiCurrencyService(currencySession: session)
    }

}
