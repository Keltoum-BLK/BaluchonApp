//
//  UIView+Extension.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 29/11/2021.
//

import Foundation
import UIKit
//MARK: Method to add shadow
extension UIView {
func addShadow() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowRadius = 20
    layer.rasterizationScale = UIScreen.main.scale
    }
    
    
}
