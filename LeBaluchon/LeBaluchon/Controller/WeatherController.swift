//
//  WeatherController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class WeatherController: UIViewController {

   
    @IBOutlet weak var weatherHeaderBackground: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
        
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        weatherHeaderBackground.layer.cornerRadius = 20
        weatherHeaderBackground.layer.cornerRadius = 20
        weatherHeaderBackground.layer.shadowColor = UIColor.black.cgColor
        weatherHeaderBackground.layer.shadowOpacity = 0.5
        weatherHeaderBackground.layer.shadowOffset = CGSize(width: 0, height: 20)
        weatherHeaderBackground.layer.shadowRadius = 20
    }
}


  
