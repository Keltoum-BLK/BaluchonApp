//
//  TranslateController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    //MARK: Properties
    private var pickerArray: [Language]?
    private var alreadyTranslate = false
    //IBOUTLET Properties
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
    
   //MARK: Methods
    func setUp() {
        originalTextField.delegate = self
        
        firstChoice.titleLabel?.numberOfLines = 0
        firstChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        firstChoice.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        secondChoice.titleLabel?.numberOfLines = 0
        secondChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        secondChoice.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
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
        
        defaultLaunchLanguages()
    }
   //Initalisation of pickerArray's property
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
    //Get the translation
    func fletchDataTranslation(pickerView: UIPickerView) {
        let sourceRow = pickerView.selectedRow(inComponent: 0)
        let targetRow = pickerView.selectedRow(inComponent: 1)
        
        guard let source = pickerArray?[sourceRow].language else { return }
        guard let target = pickerArray?[targetRow].language else { return }
        
        if source == target {
            Tools.shared.alertSameLanguage(controller: self)
        } else {
            ApiTranslateService.shared.translate(source: source, q: originalTextField.text ?? "no Text", target: target) { result in
                switch result {
                case .success(let translate):
                    DispatchQueue.main.async {
                        self.textTranslatedField.text = translate.data?.translations?.first?.translatedText
                    }
                case .failure(let error):
                    Tools.shared.AlertSelectLanguages(error: error.localizedDescription, controller: self)
                    print(error.localizedDescription)
                }
            }
        }
    }
    //Added default languages when the launch app.
    func defaultLaunchLanguages() {
        ApiTranslateService.shared.getListLanguages { result in
            switch result {
                case .success(let listOf):
                DispatchQueue.main.async {
                    self.firstChoice.setTitle(listOf.data?.languages?[29].name, for: .normal)
                    self.secondChoice.setTitle(listOf.data?.languages?[4].name, for: .normal)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func resetTextField() {
        if alreadyTranslate {
            originalTextField.text = ""
        }
    }
    //appearance of hidden picker
    @IBAction func selectLanguages(_ sender: Any) {
        originalTextField.isHidden = true
        textTranslatedField.isHidden = true
        pickLanguage.isHidden = false
    }
  //action to translate and keyboard animation
    @IBAction func TranslateAction(_ sender: Any) {
        originalTextField.resignFirstResponder()
        if originalTextField.text != "" {
            originalTextField.resignFirstResponder()
           fletchDataTranslation(pickerView: pickLanguage)
            alreadyTranslate = true
         
        } else if originalTextField.text == ""{
            Tools.shared.alertGetElementToTranslate(text: originalTextField.text ?? "no text", controller: self)
        }
    }
}

extension TranslateController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
  //MARK: methods to implementation of pickerView
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
        return NSAttributedString(string: pickerArray?[row].name ?? "no name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    //action keyboard return key and animation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        originalTextField.resignFirstResponder()
        if originalTextField.text != "" {
            originalTextField.resignFirstResponder()
           fletchDataTranslation(pickerView: pickLanguage)
            alreadyTranslate = true
            
        } else if originalTextField.text == ""{
            Tools.shared.alertGetElementToTranslate(text: originalTextField.text ?? "no text", controller: self)
        }
        return true
    }
}
