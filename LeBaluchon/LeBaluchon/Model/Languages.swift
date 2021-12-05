//
//  File.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 12/11/2021.
//

import Foundation
//MARK: STRUCT AND PROPERTIES
struct Languages: Decodable {
    let data: Datas?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
struct Datas: Decodable {
    let languages: [Language]?
    
    enum CodingKeys: String, CodingKey {
        case languages
    }
}
struct Language: Decodable {
    let language: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case language
        case name
    }
}
