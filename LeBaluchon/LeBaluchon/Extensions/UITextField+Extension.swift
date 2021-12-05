//
//  ExtensionTextField.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 09/11/2021.
//

import Foundation
import UIKit
//MARK: Method to put placeholder text color in black
extension UITextField {
    
    func putTextInBlack(text: String, textField: UITextField) {
        let blackPlaceholderText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.attributedPlaceholder = blackPlaceholderText
    }
    
}
