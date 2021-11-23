//
//  ApiTranslateService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 08/10/2021.
//

import Foundation

class ApiTranslateService {
    //MARK: Singleton
    static let shared = ApiTranslateService()
    private init() {}
    
    //MARK: Error Manager
    enum APIError: Error {
        case decoding
        case server
        case network
    }
    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var translationSession = URLSession(configuration: .default)
    
    init(translationSession: URLSession) {
        
        self.translationSession = translationSession
    }
    //MARK: Methods
    func getListLanguages(completion: @escaping (Result<Languages, APIError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2/languages"
        urlComponents.queryItems = [
            URLQueryItem(name: "target", value: "fr"),
            URLQueryItem(name: "key", value: SecretsKeys.apiKeyTranslate)]
        
        guard let urlLanguages = urlComponents.url?.absoluteString else { return }
        guard let url = URL(string: urlLanguages) else { return }
       
        dataTask = translationSession.dataTask(with: url)  { (data, response, error) in
            DispatchQueue.main.async {
            guard error == nil else { completion(.failure(.server))
                print("outch")
                return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.network))
                print("aie")
                return
            }
            guard let listOfLanguages = try? JSONDecoder().decode(Languages.self, from: data) else { completion(.failure(.decoding))
                return
            }
            completion(.success(listOfLanguages))
                dump(listOfLanguages)
        }
    }
    dataTask?.resume()
}
    

    func translate(source: String, q: String, target: String, completion: @escaping (Result<Translate, APIError>) -> Void)  {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: SecretsKeys.apiKeyTranslate),
            URLQueryItem(name: "source", value: source),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "target", value: target),
            URLQueryItem(name: "format", value: "text"),]
        
        guard let urlTranslate = urlComponents.url?.absoluteString else { return }
        guard let url = URL(string: urlTranslate) else { return }
       
        dataTask = URLSession.shared.dataTask(with: url)  { (data, response, error) in
            DispatchQueue.main.async {
            guard error == nil else { completion(.failure(.server))
                print("nope")
                return }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.network))
                print("nya")
                return
            }
            guard let translation = try? JSONDecoder().decode(Translate.self, from: data) else { completion(.failure(.decoding))
                print("Daaah")
                return
            }
            completion(.success(translation))
                dump(translation)
            }
        }
        dataTask?.resume()
    }
}
