//
//  WeatherController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class WeatherController: UIViewController {

   
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
        
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
}


  
