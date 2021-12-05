//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 17/09/2021.
//

import XCTest
@testable import LeBaluchon

class LeBaluchonTests: XCTestCase {
    
    private var tools: Tool!

    override func setUp() {
        super.setUp()
        tools = Tool()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    override func tearDownWithError() throws {
        tools = nil
    }
    
    //MARK: Tests on Constants Class
    func testGivenElements_WhenMultuplyElements_ThenReturnStringValue() {
    
        let amountText = "25"
        
        let result = tools.getTheChange(amount: amountText, with: 1.50)
        print(result)
        
        
        XCTAssert(result == "37.5")
    }
    
    
    //MARK: Tests on AlertManager Class
    //Alert in WeatherController
    func testGivenAName_WhenTheNameIsIncorrect_ThenResultAnAlert() {
        let city = ""
        let weatherVC = WeatherController()
        
        weatherVC.alertSearchCityIncorrect(city: city)
        
        XCTAssertEqual(city == "", weatherVC.alertSearchCityIncorrect(city: "") == weatherVC.alertSearchCityIncorrect(city: ""))
    }
}
