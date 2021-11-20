//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 20/11/2021.
//

import Foundation
@testable import LeBaluchon
import XCTest

class MockWeather: XCTestCase {
    
    var weatherService: ApiWeatherService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        weatherService = ApiWeatherService(weatherSession: session)
    }
    
    func testWeatherPostFailWithIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.incorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingTheWeather(city: "Paris") { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
