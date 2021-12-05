//
//  Translate.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation

//MARK: STRUCT AND PROPERTIES 
struct Translate: Decodable {
    let data: Datas?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    struct Datas: Decodable {
        let translations: [Translation]?
        
        enum CodingKeys: String, CodingKey {
            case translations = "translations"
        }
    }
    struct Translation : Decodable {
        let translatedText: String?
        
        enum CodingKeys: String, CodingKey {
            case translatedText = "translatedText"
        }
    }
    
}
