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
    
    //MARK: Error Manager
    enum APIError: Error {
        case decoding
        case server
        case network
    }
    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var currencySession = URLSession(configuration: .default)
    
    init(currencySession: URLSession) {
        
        self.currencySession = currencySession
    }
   
    func getListSymbols(completion: @escaping (Result<Symbols, APIError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/symbols"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: SecretsKeys.apiKeyCurrency)]
        
        guard let urlSymbols = urlComponents.url?.absoluteString else { return }
        guard let url = URL(string: urlSymbols) else { return }
       
        print(url)
        dataTask = URLSession.shared.dataTask(with: url)  { (data, response, error) in
            DispatchQueue.main.async {
            guard error == nil else { completion(.failure(.server))
                print("outch")
                return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.network))
                print("aie")
                return
            }
            guard let listOfSymbols = try? JSONDecoder().decode(Symbols.self, from: data) else { completion(.failure(.decoding))
                return
            }
            completion(.success(listOfSymbols))
                dump(listOfSymbols)
        }
    }
    dataTask?.resume()
}
    func getTheChange(currency1: String, countToChange: Double, currency2: String, countToGet: Double) {
        
    }

}
