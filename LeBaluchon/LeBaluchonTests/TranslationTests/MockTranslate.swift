//
//  MockTranslate.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 25/11/2021.
//

import XCTest
@testable import LeBaluchon

class MockTranslate: XCTestCase {
    
    var translationService: ApiTranslateService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLTestProtocol.self]
        let session = URLSession(configuration: configuration)
        translationService = ApiTranslateService(translationSession: session)
    }

    func testWeatherPostFailWithIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.languagesIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.getListLanguages { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testWeatherPostFailWithError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.languagesIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.getListLanguages { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testWeatherPostFailWithCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.languageCorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.getListLanguages { (result) in
            guard case .success(let pickLanguage) = result else {
                return
            }
             
            guard let languagesArray = pickLanguage.data?.languages else { return }
            
            let language = "af"
            
            XCTAssertNotNil(languagesArray)
            
            XCTAssertEqual(language, languagesArray.first?.language)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
//MARK: Translation Test API
    
    func testWeatherPostFailWithTranslationIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.translationIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.translate(source: "fr", q: "en", target: "Bonjour") { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testWeatherPostFailWithTranslationError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.translationIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.translate(source: "fr", q: "en", target: "") { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testWeatherPostFailWithTranslationCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.translationCorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        translationService.translate(source: "fr", q: "en", target: "Bonjour") { (result) in
            guard case .success(let translatedText) = result else {
                return
            }
             
            let text = "Hello"
            
            XCTAssertNotNil(translatedText)
            
            XCTAssertEqual(text, translatedText.data?.translations?.first?.translatedText)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    


}
