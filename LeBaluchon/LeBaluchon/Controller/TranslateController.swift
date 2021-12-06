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
    //IBOUTLET Properties
    @IBOutlet weak var translateHeader: UIView!
    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var textTranslatedView: UITextView!
    @IBOutlet weak var translateContainer: UIStackView!
    @IBOutlet weak var pickLanguage: UIPickerView!
    @IBOutlet weak var firstChoice: UIButton!
    @IBOutlet weak var secondChoice: UIButton!
    @IBOutlet weak var translateBTN: UIButton!
    
    @IBOutlet weak var resetBTN: UIButton!
    
    @IBOutlet weak var textToTranslateContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        fletchListOfLanguages()
        // Do any additional setup after loading the view.
    }
    
   //MARK: Methods
    func setUp() {
        originalTextView.delegate = self
        
        firstChoice.titleLabel?.numberOfLines = 0
        firstChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        firstChoice.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        secondChoice.titleLabel?.numberOfLines = 0
        secondChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        secondChoice.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        translateHeader.addShadow()
        
        translateContainer.addShadow()
        
        translateBTN.layer.cornerRadius = 20
        
        resetBTN.layer.cornerRadius = 10
        
        setupLanguagesInViewDidLoad()
    }
   //Initalisation of pickerArray's property
    func fletchListOfLanguages() {
        ApiTranslateService.shared.getLanguagesList { result in
            switch result {
                case .success(let listOf):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pickerArray = listOf.data?.languages
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    //Get the translation
    func getTranslation(pickerView: UIPickerView) {
        let sourceRow = pickerView.selectedRow(inComponent: 0)
        let targetRow = pickerView.selectedRow(inComponent: 1)
        
        guard let source = pickerArray?[sourceRow].language else { return }
        guard let target = pickerArray?[targetRow].language else { return }
        
        if source == target {
            self.alertSameLanguage()
        } else {
          fletchDataTranslation(source: source, q: originalTextView.text ?? "no Text", target: target)
        }
    }
    
    func fletchDataTranslation(source : String, q: String, target: String) {
        ApiTranslateService.shared.translate(source: source, q: q, target: target) { result in
            switch result {
            case .success(let translate):
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    self.textTranslatedView.text = translate.data?.translations?.first?.translatedText
                }
            case .failure(let error):
                self.alertServerAccess(error: error.description + "\nSélectionnes les langues pour réaliser la traduction.")
                print(error.description)
            }
        }
    }
    //Added default languages when the launch app.
    func setupLanguagesInViewDidLoad() {
        ApiTranslateService.shared.getLanguagesList { result in
            switch result { 
                case .success(let setupLanguages):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.firstChoice.setTitle(setupLanguages.data?.languages?[29].name, for: .normal)
                    self.secondChoice.setTitle(setupLanguages.data?.languages?[4].name, for: .normal)
                    self.fletchDataTranslation(source:setupLanguages.data?.languages?[29].language ?? "fr", q: self.originalTextView.text ?? "no text" , target: setupLanguages.data?.languages?[4].language ?? "en")
                }
                
            case .failure(let error):
                print(error.description)
            }
        }
        
    }
    
    //appearance of hidden picker
    @IBAction func selectLanguages(_ sender: Any) {
        originalTextView.isHidden = true
        textTranslatedView.isHidden = true
        pickLanguage.isHidden = false
        originalTextView.resignFirstResponder()
        resetBTN.isHidden = true
        textToTranslateContainer.isHidden = true
    }
  //action to translate and keyboard animation
    @IBAction func translateAction(_ sender: Any) {
        if originalTextView.text != "" {
            originalTextView.resignFirstResponder()
           getTranslation(pickerView: pickLanguage)
        } else if originalTextView.text == ""{
            self.alertWithValueError(value: originalTextView.text ?? "no text", message: "Tu as oublié ce que tu voulais traduire.")
        }
    }
    
    @IBAction func resetTextToTranslate(_ sender: Any) {
        if originalTextView.text != "" {
        originalTextView.text = Tool.shared.reset()
        } else {
            self.alertWithValueError(value: originalTextView.text, message: "Tu as déjà effacé.")
        }
    }
}

extension TranslateController: UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
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
        originalTextView.isHidden = false
        textTranslatedView.isHidden = false
        resetBTN.isHidden = false
        textToTranslateContainer.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerArray?[row].name ?? "no name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
     
}
