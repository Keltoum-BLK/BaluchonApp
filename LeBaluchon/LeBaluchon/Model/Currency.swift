//
//  Currency.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 15/11/2021.
//

import Foundation
//MARK: STRUCT AND PROPERTIES 
struct Latest: Decodable {
    let rates: [String : Double]
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    
    func createCurrencyList(dictionnary : [String : Double]) -> [CurrencyValue] {
        var listValue = [CurrencyValue]()
        for (keys, values) in dictionnary {
           let currency = CurrencyValue(code: keys, value: values)
            listValue.append(currency)
        }
        let listArr = listValue.sorted(by: { $0.code < $1.code })
        return listArr
    }
    
}

struct CurrencyValue: Decodable {
    let code: String
    let value: Double
}
