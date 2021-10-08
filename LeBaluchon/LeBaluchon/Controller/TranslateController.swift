//
//  TranslateController.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    @IBOutlet weak var translateHeader: UIView!
    @IBOutlet weak var textToTranslate: UITextField!
    @IBOutlet weak var translatedText: UITextField!
    @IBOutlet weak var translateContainer: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
        
        textToTranslate.layer.shadowRadius = 40
        translatedText.layer.shadowRadius = 40
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
