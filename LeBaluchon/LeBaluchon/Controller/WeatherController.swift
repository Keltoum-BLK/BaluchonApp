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
    let location = [CLLocation]()
    
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
        
        searchBTN.layer.cornerRadius = 10
        
        sunsetIcon.layer.cornerRadius = 40
        sunriseIcon.layer.cornerRadius = 40
    }
    
    //weather location default informations
    func flecthWeatherDataLocationDefault() {
        ApiWeatherService.shared.givingTheWeather(city: "paris") { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?.first?.description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: Constants.shared.upDatePic(image: weatherLocation.weather?.first?.icon ?? "Nopic"))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    //flecht the data with the searchField's text
    func flecthWeatherDataSearch(city: String) {
        ApiWeatherService.shared.givingTheWeather(city: city) { result in
            switch result {
            case .success(let weatherInfo):
                DispatchQueue.main.async {
                    self.cityWeather.text = weatherInfo.name ?? "Gotham"
                    self.countryWeather.text = weatherInfo.sys?.country  ?? "DCUniverse"
                    self.weatherTemperature.text = "\(Int(weatherInfo.main?.temp ?? 22)) °C"
                    self.weatherIcon.image = UIImage(named: Constants.shared.upDatePic(image:  weatherInfo.weather?.first?.icon ?? "Nopic"))
                    self.sunriseTime.text = Constants.shared.timeStamp(time: weatherInfo.sys?.sunrise ?? 0)
                    self.sunsetTime.text = Constants.shared.timeStamp(time: weatherInfo.sys?.sunset ?? 0)
                    print("=> sunrise \(weatherInfo.sys?.sunrise ?? 0)", "=> sunset \(weatherInfo.sys?.sunset ?? 0)")
                    print(self.sunriseTime.text ?? "hello")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                let description = "Veuillez saisir un nom de ville correct."
                    AlertManager.shared.alertServerAccess(city: error.localizedDescription + description, controller: self)
                }
                print(error.localizedDescription)
        }
    }
}
    
    @IBAction func searchAction(_ sender: Any) {
            searchField.resignFirstResponder()
            flecthWeatherDataSearch(city: searchField.text ?? "boston")
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
        ApiWeatherService.shared.givingLocationWeather(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0) { result in
            switch result {
            case .success(let weatherLocation):
                DispatchQueue.main.async {
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?.first?.description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: Constants.shared.upDatePic(image: weatherLocation.weather?.first?.icon ?? "Nopic"))
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
    //Keyboard action and animation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        if searchField.text != "" {
            searchField.resignFirstResponder()
            flecthWeatherDataSearch(city: searchField.text ?? "boston")
        } else if searchField.text == ""{
            AlertManager.shared.alertAddCity(city: searchField.text ?? "boston", controller: self)
        }
        return true
    }
}


