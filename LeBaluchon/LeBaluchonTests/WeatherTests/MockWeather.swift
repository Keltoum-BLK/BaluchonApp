//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by Kel_Jellysh on 20/11/2021.
//


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
    
    func testGetWeatherShouldPostFailWithIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.weatherIncorrectData
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
    
    func testGetWeatherShouldPostFailWithError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.weatherIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingTheWeather(city: "") { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostSuccessWithNoErrorAndCorrectWeatherData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingTheWeather(city: "Paris") { (result) in
            print(result)
            guard case .success(let weatherInfo) = result else {
                return
            }
            let city = "Paris"
            let country = "FR"
            let description = "couvert"
            let temperature = 10.96
            let sunrise = 1637305560
            let sunset = 1637337981
            let icon = "04d"
            XCTAssertNotNil(weatherInfo)
            
            XCTAssertEqual(city, weatherInfo.name)
            XCTAssertEqual(country, weatherInfo.sys?.country)
            XCTAssertEqual(description, weatherInfo.weather?.first?.description)
            XCTAssertEqual(temperature, weatherInfo.main?.temp)
            XCTAssertEqual(sunrise, weatherInfo.sys?.sunrise)
            XCTAssertEqual(sunset, weatherInfo.sys?.sunset)
            XCTAssertEqual(icon, weatherInfo.weather?.first?.icon)
            
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailWithLocationIncorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.weatherIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingLocationWeather(latitude: 48.8534, longitude: 2.3488) { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testGetWeatherLocationShouldPostFailWithError() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO!
            let error: Error? = nil
            let data = FakeResponseData.weatherIncorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingLocationWeather(latitude: 0, longitude: 0) { (result) in
            print(result)
            guard case .failure(let error) = result else { XCTFail("failure")
                return
            }
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherLocationShouldPostSuccessWithNoErrorAndCorrectData() {
        
        URLTestProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK!
            let error: Error? = nil
            let data = FakeResponseData.weatherCorrectData
            return (response, data, error)
        }
   
        let expectation = XCTestExpectation(description: "wait for change")
        
        weatherService.givingLocationWeather(latitude: 48.8534, longitude: 2.3488) { (result) in
            print(result)
            guard case .success(let weatherInfo) = result else {
                return
            }
            let city = "Paris"
            let country = "FR"
            let description = "couvert"
            let temperature = 10.96
            let sunrise = 1637305560
            let sunset = 1637337981
            let icon = "04d"
            
            XCTAssertNotNil(weatherInfo)
            
            XCTAssertEqual(city, weatherInfo.name)
            XCTAssertEqual(country, weatherInfo.sys?.country)
            XCTAssertEqual(description, weatherInfo.weather?.first?.description)
            XCTAssertEqual(temperature, weatherInfo.main?.temp)
            XCTAssertEqual(sunrise, weatherInfo.sys?.sunrise)
            XCTAssertEqual(sunset, weatherInfo.sys?.sunset)
            XCTAssertEqual(icon, weatherInfo.weather?.first?.icon)
            
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
