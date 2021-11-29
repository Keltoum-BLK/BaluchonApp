//
//  Constants.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import Foundation
import UIKit

class Tool {
   //MARK: Proporties
    static let shared = Tool()
    
    //MARK: METHOD
    func getTheChange(amount: String, with currencyvalue: Double) -> String {
            let doubleStr = Double(amount)
            guard let multiply = doubleStr else { return "no info"}
            var result = currencyvalue * multiply
            result = round(result * 100) / 100
            let resultStr = String(result)
            return resultStr
    }
    
}

