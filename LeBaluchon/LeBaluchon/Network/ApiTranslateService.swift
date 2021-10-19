//
//  ApiTranslateService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 08/10/2021.
//

import Foundation

class ApiTranslateService {

    static let shared = ApiTranslateService()
    private var dataTask: URLSessionDataTask?
    let apiKeyTranslate = "AIzaSyCo95wNsNcsUAMC0PIowXUQjEtnSFx5sjk"
    
    enum NetworkError: Error {
        case badUrl
        case invalidData
        case network
    }
    
    func translate(source: String, q: String, target: String) {
        
        let urlTranslate = "https://translation.googleapis.com/language/translate/v2?key=\(apiKeyTranslate)&source=\(source)&target=\(target)&q=\(q)"
        
        guard let url = URL(string: urlTranslate) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
    
        }
    
    }
}
