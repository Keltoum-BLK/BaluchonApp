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
    //Locoation properties
    private let manager = CLLocationManager()
    private let location = [CLLocation]()
    
    //IBOUTLET properties
    @IBOutlet weak var weatherHeaderBackground: UIView!
    @IBOutlet weak var myLocationLabel: UIView!
    @IBOutlet weak var locationPlace: UILabel!
    @IBOutlet weak var weatherLocationIcon: UIImageView!
    @IBOutlet weak var searchBTN: UIButton!
    @IBOutlet weak var countryWeather: UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var sunriseIcon: UIImageView!
    @IBOutlet weak var sunsetIcon: UIImageView!
    @IBOutlet weak var searchField: UITextField! {
        didSet {
            searchField.putTextInBlack(text: "Saisis la ville ici. 📍", textField: searchField)
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
    
    //MARK: Methods
    //Set of the weather UI and interface.
    func setUp() {
        searchField.delegate = self
        searchField.layer.cornerRadius = 20
        
        weatherHeaderBackground.addShadow()
        
        myLocationLabel.addShadow()
        
        searchBTN.layer.cornerRadius = 10
        
        sunsetIcon.layer.cornerRadius = 40
        sunriseIcon.layer.cornerRadius = 40
    }
    
    //weather location default informations
    func flecthWeatherDataLocationDefault() {
        ApiWeatherService.shared.getTheWeather(city: "paris") { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?.first?.description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: weatherLocation.upDatePic(image: weatherLocation.weather?.first?.icon ?? "Nopic"))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    //flecht the data with the searchField's text
    func flecthWeatherDataSearch(city: String) {
        ApiWeatherService.shared.getTheWeather(city: city) { result in
            switch result {
            case .success(let weatherInfo):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.cityWeather.text = weatherInfo.name ?? "Gotham"
                    self.countryWeather.text = weatherInfo.sys?.country  ?? "DCUniverse"
                    self.weatherTemperature.text = "\(Int(weatherInfo.main?.temp ?? 22)) °C"
                    self.weatherIcon.image = UIImage(named: weatherInfo.upDatePic(image: weatherInfo.weather?.first?.icon ?? "Nopic"))
                    self.sunriseTime.text = weatherInfo.timeStamp(time: weatherInfo.sys?.sunrise ?? 0)
                    self.sunsetTime.text = weatherInfo.timeStamp(time: weatherInfo.sys?.sunset ?? 0)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let description = "\nSaisis un nom de ville correct."
                    self.alertServerAccess(error: error.description + description)
                }
                print(error.description)
            }
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
            searchField.resignFirstResponder()
            flecthWeatherDataSearch(city: searchField.text ?? "boston")
            self.alertSearchCityIncorrect(city: searchField.text ?? "boston")
    }
}
//MARK: Extension for implementation of Core Localisation
extension WeatherController: CLLocationManagerDelegate, UITextFieldDelegate {
    
    //MARK: methods
    func setupLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    //Add localization information to the view
    func fletchWeatherLocation() {
        ApiWeatherService.shared.getLocationWeather(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0) { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?.first?.description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: weatherLocation.upDatePic(image: weatherLocation.weather?.first?.icon ?? "Nopic"))
                }
            case .failure(let error):
                print(error.description)
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
    //Keyboard action and animation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchField.resignFirstResponder()
            flecthWeatherDataSearch(city: searchField.text ?? "boston")
            self.alertSearchCityIncorrect(city: searchField.text ?? "boston")
        return true
    }
}


