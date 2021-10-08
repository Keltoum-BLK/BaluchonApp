//
//  ApiService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation


class ApiCurrencyService {
    
    static let shared = ApiCurrencyService()
    
   
    let apiKeyCurrency = "03479052e9afb24dc5416b800447e4ad"
    
    func getTheCurrency() -> String {
        let listOfCurrenciesUrl = "http://data.fixer.io/api/symbols?access_key=\(apiKeyCurrency)"
        
        return "DZD"
    }
    
    func getTheGoodChange(){
        
    }
    
    func getTheChange(currency1: String, countToChange: Double, currency2: String, countToGet: Double) {
        
    }

}
