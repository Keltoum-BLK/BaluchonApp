//
//  WeatherController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class WeatherController: UIViewController {

   //MARK: Properties
    private var infoIcon: PageWeather?
    
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
    @IBOutlet weak var searchCity: UISearchBar!
    @IBOutlet weak var sunTimeContainer: UIStackView!
    @IBOutlet weak var weatherContainer: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        flecthWeatherDataLocationDefault()
        flecthWeatherDataSearch(city: "Bamako")
        
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
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
                    print(weatherLocation)
                   
                    self.locationPlace.text = "\(Int(weatherLocation.main?.temp ?? 0))°C, \(weatherLocation.weather?[0].description ?? "BatSignal"), \(weatherLocation.name ?? "Gotham"), \(weatherLocation.sys?.country  ?? "DCUniverse")"
                    self.weatherLocationIcon.image = UIImage(named: self.upDatePic(image: weatherLocation.weather?[0].icon ?? "Nopic"))
                }
            case .failure(let error):
                            print(error.localizedDescription)
            }
        }
      
    }
    
    func flecthWeatherDataSearch(city: String) {
        ApiWeatherService.shared.givingTheWeather(city: city) { result in
            switch result {
            case .success(let weatherInfo):
                DispatchQueue.main.async {
                    print(weatherInfo)
    
                    self.cityWeather.text = weatherInfo.name ?? "Gotham"
                    self.countryWeather.text = weatherInfo.sys?.country  ?? "DCUniverse"
                    self.weatherTemperature.text = "\(Int(weatherInfo.main?.temp ?? 22)) °C"
                    self.weatherIcon.image = UIImage(named: self.upDatePic(image:  weatherInfo.weather?[0].icon ?? "Nopic"))
                }
            case .failure(let error):
                            print(error.localizedDescription)
            }
        }
    }
    // mettre cette méthode dans Constants
    func upDatePic(image: String) -> String {
        if image == "", image != infoIcon?.weather?[0].icon {
            return "Nopic"
        } else {
            return image
        }
    }
}


  
