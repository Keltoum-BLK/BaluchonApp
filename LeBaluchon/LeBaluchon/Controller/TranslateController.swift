//
//  TranslateController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    var pickerArray: [Language]?
    
    @IBOutlet weak var translateHeader: UIView!
    @IBOutlet weak var originalTextField: UITextField! {
        didSet {
            originalTextField.putTextInBlack(text: "Que veux-tu traduire?", textField: originalTextField)
        }
    }
    @IBOutlet weak var textTranslatedField: UITextField! {
        didSet {
            textTranslatedField.putTextInBlack(text: "Voici la traduction.", textField: textTranslatedField)
        }
    }
    @IBOutlet weak var translateContainer: UIStackView!
    @IBOutlet weak var pickLanguage: UIPickerView!
    @IBOutlet weak var firstChoice: UIButton!
    @IBOutlet weak var secondChoice: UIButton!
    @IBOutlet weak var translateBTN: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        fletchListOfLanguages()
        // Do any additional setup after loading the view.
    }
    
    
    func setUp() {
      
        translateHeader.layer.cornerRadius = 20
        translateHeader.layer.cornerRadius = 20
        translateHeader.layer.shadowColor = UIColor.black.cgColor
        translateHeader.layer.shadowOpacity = 0.5
        translateHeader.layer.shadowOffset = CGSize(width: 0, height: 20)
        translateHeader.layer.shadowRadius = 20
        
        translateContainer.layer.cornerRadius = 20
        translateContainer.layer.shadowColor = UIColor.black.cgColor
        translateContainer.layer.shadowOpacity = 0.5
        translateContainer.layer.shadowOffset = CGSize(width: 0, height: 20)
        translateContainer.layer.shadowRadius = 20
        translateBTN.layer.cornerRadius = 20
        
        firstChoice.setTitle("Français", for: .normal)
        secondChoice.setTitle("Anglais", for: .normal)
        
        
    }
    
    func fletchListOfLanguages() {
        ApiTranslateService.shared.getListLanguages { result in
            switch result {
                case .success(let listOf):
                DispatchQueue.main.async {
                    self.pickerArray = listOf.data?.languages
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fletchDataTranslation(pickerView: UIPickerView) {
        let sourceRow = pickerView.selectedRow(inComponent: 0)
        let targetRow = pickerView.selectedRow(inComponent: 1)
        
        guard let source = pickerArray?[sourceRow].language else { return }
        guard let target = pickerArray?[targetRow].language else { return }
        
        ApiTranslateService.shared.translate(source: source, q: originalTextField.text ?? "Bonjour", target: target) { result in
            switch result {
            case .success(let translate):
            DispatchQueue.main.async {
                self.textTranslatedField.text = translate.data?.translations?.first?.translatedText
            }
        case .failure(let error):
            print(error.localizedDescription)
            }
        }
        
    }
    
    @IBAction func selectLanguages(_ sender: Any) {
        originalTextField.isHidden = true
        textTranslatedField.isHidden = true
        pickLanguage.isHidden = false
    }
    
    @IBAction func TranslateAction(_ sender: Any) {
        originalTextField.resignFirstResponder()
        if originalTextField.text != "" {
            originalTextField.resignFirstResponder()
           fletchDataTranslation(pickerView: pickLanguage)
        } else if originalTextField.text == ""{
            Constants.shared.alertTextEmpty(text: originalTextField.text ?? "Pas bien", controller: self)
        }
    }
}


extension TranslateController : UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
  
    func setupDelegate() {
        pickLanguage.delegate = self
        pickLanguage.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return pickerArray?.count ?? 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray?[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstLanguage = pickerView.selectedRow(inComponent: 0)
        let secondLanguage = pickerView.selectedRow(inComponent: 1)
        
        firstChoice.setTitle(pickerArray?[firstLanguage].name, for: .normal)
        secondChoice.setTitle(pickerArray?[secondLanguage].name, for: .normal)
        
        pickLanguage.isHidden = true
        originalTextField.isHidden = false
        textTranslatedField.isHidden = false
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerArray?[row].name ?? "Midgard", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        originalTextField.resignFirstResponder()
        if originalTextField.text != "" {
            originalTextField.resignFirstResponder()
           fletchDataTranslation(pickerView: pickLanguage)
        } else if originalTextField.text == ""{
            Constants.shared.alertTextEmpty(text: originalTextField.text ?? "Pas bien", controller: self)
        }
        return true
    }
}
