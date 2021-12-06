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
    private var codeSelected = ""
    
    //IBOUTLET Properties
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
    @IBOutlet weak var choiceContainer: UIStackView!
    
    @IBOutlet weak var amountContainer: UIView!
    @IBOutlet weak var resetBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setup()
        setupPicker()
        fletchListOfCurrenciesNames()
        fletchListOfCurrency()
        
    }
    //MARK: Methods
    
    //SetUP Title Page
    func setUpHeader() {
        currencyHeader.addShadow()
    }
    //Setup widgets
    func setup() {
        startingCurrencyField.delegate = self
        
        startingCurrencyBTN.titleLabel?.numberOfLines = 0
        startingCurrencyBTN.titleLabel?.adjustsFontSizeToFitWidth = true
        startingCurrencyBTN.titleLabel?.lineBreakMode = .byClipping
        
        
        returnCurrencyBTN.titleLabel?.numberOfLines = 2
        returnCurrencyBTN.titleLabel?.adjustsFontSizeToFitWidth = true
        returnCurrencyBTN.titleLabel?.lineBreakMode = .byClipping
        
        converthBTN.layer.cornerRadius = 20
        
        currencyContainer.addShadow()
        
        resetBTN.layer.cornerRadius = 10
        
        choiceContainer.layer.cornerRadius = 20
        defaultCurrencies()
    }
   
    //Get the symbols list
    func fletchListOfCurrenciesNames() {
        ApiCurrencyService.shared.getSymbolsList { result in
            switch result {
            case .success(let listOf):
                DispatchQueue.main.async { 
                    self.pickerSymbols = listOf.createSymbolsList(dictionnary: listOf.symbols)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    //Get Currencies Values in a array.
    func fletchListOfCurrency() {
        ApiCurrencyService.shared.getTheCurrencyValue { result in
            switch result {
            case .success(let valueList):
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                    self.pickerValues = valueList.createCurrencyList(dictionnary: valueList.rates)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    //get the currency default in the launch page.
    func defaultCurrencies() {
        ApiCurrencyService.shared.getSymbolsList { result in
            switch result {
            case .success(let symbols):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pickerSymbols = symbols.createSymbolsList(dictionnary: symbols.symbols)
                    self.startingCurrencyBTN.setTitle(self.pickerSymbols[51].name, for: .normal)
                    self.returnCurrencyBTN.setTitle("Choisis", for: .normal)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    //Get the currency change
    func getCurrencyChange(with picker: UIPickerView) {
        if codeSelected.isEmpty || startingCurrencyField.text?.first == "0" || startingCurrencyField.text?.first == "." || startingCurrencyField.text == "" {
            self.alertWithValueError(value: startingCurrencyField.text ?? "no info", message: "Tu as oublié le montant ou la devise.")
        } else {
            guard let codeValue = pickerValues.first(where: { $0.code == codeSelected })?.value else { return }
            
            returnCurrencyField.text =  Tool.shared.getTheChange(amount: startingCurrencyField.text ?? "0", with: codeValue)
        }
    }
    //appearance of hidden picker
    @IBAction func selectCurrency(_ sender: Any) {
        startingCurrencyField.isHidden = true
        returnCurrencyField.isHidden = true
        pickerCurrency.isHidden = false
        resetBTN.isHidden = true
        amountContainer.isHidden = true
    }
    //action and animation of keyboard
    @IBAction func getCurrencyAction(_ sender: Any) {
        startingCurrencyField.resignFirstResponder()
        if startingCurrencyField.text != "" {
            startingCurrencyField.resignFirstResponder()
            getCurrencyChange(with: pickerCurrency)
        } else {
            self.alertWithValueError(value: startingCurrencyField.text ?? "no info", message: "Tu as oublié le montant ou la devise.")
        }
    }
    
    
    @IBAction func resetCurrency(_ sender: Any) {
        if startingCurrencyField.text != "" {
        startingCurrencyField.text = Tool.shared.reset()
        } else {
            self.alertWithValueError(value: startingCurrencyField.text ?? "no info", message: "Tu as déjà effacé.")
        }
    }
}

//MARK: Implementation of pickerView and Textfield methods.
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
    //pick the currency wished
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    
        startingCurrencyBTN.setTitle(pickerSymbols[51].name, for: .normal)
        returnCurrencyBTN.setTitle(pickerSymbols[row].name, for: .normal)
        
        if pickerView == pickerCurrency {
            self.codeSelected = pickerSymbols[row].code
        }

        pickerCurrency.isHidden = true
        startingCurrencyField.isHidden = false
        returnCurrencyField.isHidden = false
        resetBTN.isHidden = false
        amountContainer.isHidden = false
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerSymbols[row].name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }

}
