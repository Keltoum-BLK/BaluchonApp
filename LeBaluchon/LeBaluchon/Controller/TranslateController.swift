//
//  TranslateController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    @IBOutlet weak var translateHeader: UIView!
    @IBOutlet weak var translateField: UITextField! {
        didSet {
            translateField.putTextInBlack(text: "Que veux-tu traduire?", textField: translateField)
        }
    }
    @IBOutlet weak var fieldTranslated: UITextField! {
        didSet {
            fieldTranslated.putTextInBlack(text: "Voici la traduction.", textField: fieldTranslated)
        }
    }
    @IBOutlet weak var translateContainer: UIStackView!
    @IBOutlet weak var pickLanguage: UIPickerView!
    @IBOutlet weak var firstChoice: UIButton!
    @IBOutlet weak var goTranslateBtn: UIButton!
    @IBOutlet weak var secondChoice: UIButton!
    @IBOutlet weak var switchChoice: UIButton!
    
    let pickerArray: [String] = Constants.shared.languageArray
    var translateBtnTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    
    func setUp() {
        pickLanguage.delegate = self
        pickLanguage.dataSource = self
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
        switchChoice.layer.cornerRadius = 20
        goTranslateBtn.layer.cornerRadius = 20
    }
    
    
    
    @IBAction func selectLanguages(_ sender: Any) {
        translateField.isHidden = true
        fieldTranslated.isHidden = true
        pickLanguage.isHidden = false
    }
    
    
    @IBAction func switchLanguages(_ sender: Any) {
        
        let firstButtonText = firstChoice.titleLabel?.text
        firstChoice.setTitle(secondChoice.titleLabel?.text, for: .normal)
        secondChoice.setTitle(firstButtonText, for: .normal)
        
        Constants.shared.swapString(string1: &(translateField.text)!, string2: &(fieldTranslated.text)!)
        
    }
    

    @IBAction func goTranslate(_ sender: Any) {
        
    }
    
}

extension TranslateController : UIPickerViewDelegate, UIPickerViewDataSource {
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstLanguage = pickerView.selectedRow(inComponent: 0)
        let secondLanguage = pickerView.selectedRow(inComponent: 1)
        
        firstChoice.setTitle(pickerArray[firstLanguage], for: .normal)
        secondChoice.setTitle(pickerArray[secondLanguage], for: .normal)
        
        pickLanguage.isHidden = true
        translateField.isHidden = false
        fieldTranslated.isHidden = false
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}
