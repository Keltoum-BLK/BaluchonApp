//
//  HomeViewController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 17/09/2021.
//

import UIKit
import SwiftyGif

class CurrencyViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var currencyHeader: UIView!
   
    @IBOutlet weak var startingCurrencyLabel: UILabel!
    @IBOutlet weak var startingCurrencyField: UITextField!
    @IBOutlet weak var switchBTN: UIButton!
    @IBOutlet weak var returnCurrencyLabel: UILabel!
    @IBOutlet weak var returnCurrencyField: UITextField!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setup()
    }
    
    func setUpHeader() {
        currencyHeader.layer.cornerRadius = 20
        currencyHeader.layer.shadowColor = UIColor.black.cgColor
        currencyHeader.layer.shadowOpacity = 0.5
        currencyHeader.layer.shadowOffset = CGSize(width: 0, height: 20)
        currencyHeader.layer.shadowRadius = 20
    }

    func setup() {
        switchBTN.layer.cornerRadius = 20
    }
    
    
}

//extension HomeViewController: SwiftyGifDelegate {
//    func gifDidStop(sender: UIImageView) {
//        logoAnimationView.isHidden = true
//
//
//
//    }
//}
