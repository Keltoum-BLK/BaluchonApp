//
//  Currency.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation
//MARK: STRUCT AND PROPERTIES 
struct Symbols: Decodable {
    let success: Bool
    let symbols: [String : String]
    
    enum CodingKeys: String,CodingKey {
        case success
        case symbols
    }
}
struct Currency: Decodable {
    var code: String
    var name: String
}
