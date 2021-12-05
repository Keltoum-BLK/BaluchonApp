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
    //MARK: Currency Tests API getSymbolsList()
    func testGetTheCurrencyShouldPostFailWithCurrencyIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.currencySymbolsIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        currencyService.getSymbolsList { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTheCurrencyShouldPostFailWithError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.currencySymbolsIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        currencyService.getSymbolsList { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testGetTheCurrencyShouldPostSuccessWithCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.currencySymbolsCorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        currencyService.getSymbolsList { (result) in
            guard case .success(let currencies) = result else {
                return
            }
            
            let pickCurrency = currencies.createSymbolsList(dictionnary: currencies.symbols)
            
            let currency = "EUR"
            let currencyName = "Euro"
            
            XCTAssertNotNil(pickCurrency)
            
            XCTAssertEqual(currency, pickCurrency[51].code)
            XCTAssertEqual(currencyName, pickCurrency[51].name)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: Currency Tests API getChange()
    func testGetTheCurrencyValueShouldPostFailWithIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.currencyValueIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        currencyService.getTheCurrencyValue { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTheCurrencyValueShouldPostFailWithError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.currencyValueIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        currencyService.getTheCurrencyValue { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testGetTheCurrencyValueShouldPostSuccessWithCorrectData() {

        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.currencyValueCorrectData
            return (response, data, error)
        }

        let expectation = XCTestExpectation(description: "wait for change")

        currencyService.getTheCurrencyValue { (result) in
            guard case .success(let currenciesValues) = result else {
                return
            }

            let pickValue = currenciesValues.createCurrencyList(dictionnary: currenciesValues.rates)
            
            let currency = "DZD"
            let value = 157.063134
            
            XCTAssertNotNil(pickValue)
            dump(pickValue)
            XCTAssertEqual(currency, pickValue[42].code)
            XCTAssertEqual(value, pickValue[42].value)
           
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
