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
    private var pickerSymbols = [Currency]()
    private var pickerValues = [CurrencyValue]()
    private var alreadyConvert = false
    
    @IBOutlet weak var currencyHeader: UIView!
    @IBOutlet weak var startingCurrencyBTN: UIButton!
    @IBOutlet weak var startingCurrencyField: UITextField! {
        didSet {
            startingCurrencyField.putTextInBlack(text: "Saisis le montant 💵.", textField: startingCurrencyField)
        }
    }
    @IBOutlet weak var converthBTN: UIButton!
    @IBOutlet weak var returnCurrencyBTN: UIButton!
    @IBOutlet weak var returnCurrencyField: UITextField! {
        didSet {
            returnCurrencyField.putTextInBlack(text: "La valeur dans la devise demandée. 💰", textField: returnCurrencyField)
        }
    }
    @IBOutlet weak var pickerCurrency: UIPickerView!
    @IBOutlet weak var currencyContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setup()
        setupPicker()
        fletchListOfCurrenciesNames()
        fletchListOfCurrency()
        
    }
    
    func setUpHeader() {
        currencyHeader.layer.cornerRadius = 20
        currencyHeader.layer.shadowColor = UIColor.black.cgColor
        currencyHeader.layer.shadowOpacity = 0.5
        currencyHeader.layer.shadowOffset = CGSize(width: 0, height: 20)
        currencyHeader.layer.shadowRadius = 20
    
    }

    func setup() {
        startingCurrencyField.delegate = self
        
        startingCurrencyBTN.titleLabel?.numberOfLines = 0
        startingCurrencyBTN.titleLabel?.adjustsFontSizeToFitWidth = true
        startingCurrencyBTN.titleLabel?.lineBreakMode = .byClipping
        
        
        returnCurrencyBTN.titleLabel?.numberOfLines = 0
        returnCurrencyBTN.titleLabel?.adjustsFontSizeToFitWidth = true
        returnCurrencyBTN.titleLabel?.lineBreakMode = .byClipping
        
        converthBTN.layer.cornerRadius = 20
        
        currencyContainer.layer.shadowColor = UIColor.black.cgColor
        currencyContainer.layer.shadowOpacity = 0.5
        currencyContainer.layer.shadowOffset = CGSize(width: 0, height: 20)
        currencyContainer.layer.shadowRadius = 20
        
        defaultCurrencies()
    }
    
    func fletchListOfCurrenciesNames() {
        ApiCurrencyService.shared.getListSymbols { result in
            switch result {
            case .success(let listOf):
                DispatchQueue.main.async {
//                    guard let list = listOf.symbols else { return }
                    self.pickerSymbols = Constants.shared.createSymbolsList(dictionnary: listOf.symbols)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func fletchListOfCurrency() {
        ApiCurrencyService.shared.getTheChange { result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    guard let listValues = list.rates else { return }
                    self.pickerValues = Constants.shared.createCurrencyList(dictionnary: list.rates ?? listValues)
                    dump(self.pickerValues)

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func defaultCurrencies() {
        ApiCurrencyService.shared.getListSymbols { result in
            switch result {
            case .success(let listOf):
                DispatchQueue.main.async {
                    self.pickerSymbols = Constants.shared.createSymbolsList(dictionnary: listOf.symbols)
                    self.startingCurrencyBTN.setTitle(self.pickerSymbols[51].name, for: .normal)
                    self.returnCurrencyBTN.setTitle(self.pickerSymbols[158].name, for: .normal)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCurrencyChnage(with picker: UIPickerView) {
    
        
    }
    
    @IBAction func selectCurrency(_ sender: Any) {
        startingCurrencyField.isHidden = true
        returnCurrencyField.isHidden = true
        pickerCurrency.isHidden = false
    }
    
    @IBAction func getCurrencyAction(_ sender: Any) {
        startingCurrencyField.resignFirstResponder()
        if startingCurrencyField.text != "" {
            startingCurrencyField.resignFirstResponder()
        } else if startingCurrencyField.text == "" {
            AlertManager.shared.alertTextEmpty(text: startingCurrencyField.text ?? "no text", controller: self)
        }
        
    }
    
}

extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {


    func setupPicker() {
        pickerCurrency.delegate = self
        pickerCurrency.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSymbols.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSymbols[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstCurrency = pickerView.selectedRow(inComponent: 0)
       

        startingCurrencyBTN.setTitle(pickerSymbols[51].name, for: .normal)
        returnCurrencyBTN.setTitle(pickerSymbols[firstCurrency].name, for: .normal)

        pickerCurrency.isHidden = true
        startingCurrencyField.isHidden = false
        returnCurrencyField.isHidden = false
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerSymbols[row].name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }

}
