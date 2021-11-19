//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 17/09/2021.
//

import XCTest
@testable import LeBaluchon

class LeBaluchonTests: XCTestCase {
    
    private var constants: Constants!

    override func setUp() {
        super.setUp()
        constants = Constants()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    override func tearDownWithError() throws {
        constants = nil
    }
    
    //MARK: Tests on Constants Class
    func testGivenStringDateValue_WhenHavingAInt_ThenHavingADateAndHours() {
        let timeStamp = 1637331057
        
        constants.resultStr = constants.timeStamp(time: timeStamp)
        
        XCTAssert(constants.resultStr == "19-11-2021 15:10")
    }
    
    
    //MARK: Tests on AlertManager Class
}
