//
//  WeatherController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit
import CoreLocation

class WeatherController: UIViewController {
    
    //MARK: Properties
    private let manager = CLLocationManager()
    let location = [CLLocation]()
    
    @IBOutlet weak var weatherHeaderBackground: UIView!
    @IBOutlet weak var myLocationLabel: UIView!
    @IBOutlet weak var locationPlace: UILabel!
    @IBOutlet weak var weatherLocationIcon: UIImageView!
    @IBOutlet weak var searchWeatherLocation: UIButton!
    @IBOutlet weak var countryWeather: UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var sunriseIcon: UIImageView!
    @IBOutlet weak var sunsetIcon: UIImageView!
    @IBOutlet weak var searchCity: UITextField! {
        didSet {
            searchCity.putTextInBlack(text: "Saisis la ville ici. 📍", textField: searchCity)
        }
    }
    @IBOutlet weak var sunTimeContainer: UIStackView!
    @IBOutlet weak var weatherContainer: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        setUp()
        flecthWeatherDataLocationDefault()
        flecthWeatherDataSearch(city: "new york")
    }
    
    func setUp() {
        searchCity.delegate = self
        
        weatherHeaderBackground.layer.cornerRadius = 20
        weatherHeaderBackground.layer.shadowColor = UIColor.black.cgColor
        weatherHeaderBackground.layer.shadowOpacity = 0.5
        weatherHeaderBackground.layer.shadowOffset = CGSize(width: 0, height: 20)
        weatherHeaderBackground.layer.shadowRadius = 20
        
        myLocationLabel.layer.cornerRadius = 10
        myLocationLabel.layer.shadowColor = UIColor.black.cgColor
        myLocationLabel.layer.shadowOpacity = 0.5
        myLocationLabel.layer.shadowOffset = CGSize(width: 0, height: 10)
        myLocationLabel.layer.shadowRadius = 10
        
        searchWeatherLocation.layer.cornerRadius = 10
        
        sunsetIcon.layer.cornerRadius = 40
        sunriseIcon.layer.cornerRadius = 40
    }
    
    
    func flecthWeatherDataLocationDefault() {
        ApiWeatherService.shared.givingTheWeather(city: "paris") { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?[0].description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: Constants.shared.upDatePic(image: weatherLocation.weather?[0].icon ?? "Nopic"))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func flecthWeatherDataSearch(city: String) {
        ApiWeatherService.shared.givingTheWeather(city: city) { result in
            Constants.shared.alertSearchCityAction(city: city, controller: WeatherController())
            switch result {
            case .success(let weatherInfo):
                DispatchQueue.main.async {
                    self.cityWeather.text = weatherInfo.name ?? "Gotham"
                    self.countryWeather.text = weatherInfo.sys?.country  ?? "DCUniverse"
                    self.weatherTemperature.text = "\(Int(weatherInfo.main?.temp ?? 22)) °C"
                    self.weatherIcon.image = UIImage(named: Constants.shared.upDatePic(image:  weatherInfo.weather?[0].icon ?? "Nopic"))
                    self.sunriseTime.text = Constants.shared.timeStamp(time: weatherInfo.sys?.sunrise ?? 0)
                    self.sunsetTime.text = Constants.shared.timeStamp(time: weatherInfo.sys?.sunset ?? 0)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func searchBTN(_ sender: Any) {
        searchCity.resignFirstResponder()
        if let text = searchCity.text {
            flecthWeatherDataSearch(city: text)
        }
    }
}

extension WeatherController: CLLocationManagerDelegate, UITextFieldDelegate {
    
    func setupLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //        if manager.authorizationStatus == .authorizedWhenInUse, manager.authorizationStatus == .authorizedAlways {
        //           locationWeather()
        //        } else {
        //            flecthWeatherDataLocationDefault()
        //        }
    }
    
    func fletchWeatherLocation() {
        ApiWeatherService.shared.givingLocationWeather(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0) { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?[0].description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: Constants.shared.upDatePic(image: weatherLocation.weather?[0].icon ?? "Nopic"))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.authorizationStatus == .denied {
            flecthWeatherDataLocationDefault()
        } else {
            fletchWeatherLocation()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCity.resignFirstResponder()
        if let text = searchCity.text {
            flecthWeatherDataSearch(city: text)
        }
        return true
    }
}


