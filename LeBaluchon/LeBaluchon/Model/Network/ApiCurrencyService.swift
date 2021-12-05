//
//  ApiService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation


class ApiCurrencyService {

    //MARK: Singleton
    static let shared = ApiCurrencyService()
    private init() {}

    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var currencySession = URLSession(configuration: .default)
    
    init(currencySession: URLSession) {
        
        self.currencySession = currencySession
    }
   
    //MARK: Methods
    func getSymbolsList(completion: @escaping (Result<Symbols, APIError>) -> Void) {
        //using the type of url syntaxe for use the scheme http after update infoplist
        guard let url = URL(string: "http://data.fixer.io/api/symbols?access_key=\(SecretsKeys.apiKeyCurrency)") else { return }
        
        dataTask = currencySession.dataTask(with: url)  { (data, response, error) in
            DispatchQueue.main.async {
            guard error == nil else { completion(.failure(.server))
                return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.network))
                return
            }
            guard let listOfSymbols = try? JSONDecoder().decode(Symbols.self, from: data) else { completion(.failure(.decoding))
                return
            }
            completion(.success(listOfSymbols))
                
        }
    }
        dataTask?.resume()
}
    func getTheCurrencyValue(completion :  @escaping (Result<Latest, APIError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(SecretsKeys.apiKeyCurrency)") else { return }
   
        dataTask = currencySession.dataTask(with: url)  { (data, response, error) in
            DispatchQueue.main.async {
            guard error == nil else { completion(.failure(.server))
                return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.network))
                return
            }
            guard let listOfValues = try? JSONDecoder().decode(Latest.self, from: data) else { completion(.failure(.decoding))
                return
            }
            completion(.success(listOfValues))
        }
    }
        dataTask?.resume()
    }

}
