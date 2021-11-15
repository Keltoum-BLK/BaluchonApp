//
//  Currency.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 15/11/2021.
//

import Foundation

struct Latest: Decodable {
    let rates: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
}

struct CurrencyValue: Decodable {
    let code: String?
    let value: Double?
}
