//
//  ApiTranslateService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 08/10/2021.
//

import Foundation

class ApiTranslateService {
    
    static let shared = ApiTranslateService()
    
    let apiKeyTranslate = "AIzaSyCo95wNsNcsUAMC0PIowXUQjEtnSFx5sjk"
    
    func translate(source: String, q: String, target: String){
        let urlTranslate = "https://translation.googleapis.com/language/translate/v2?key=\(apiKeyTranslate)&source=\(source)&target=\(target)&q=\(q)"
    }
    
}
