//
//  Network.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void)
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void)
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


final class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    
    //        private init() {}
    
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                #warning("убрать дебаг")
                //print("DATA:\n", data, "\nRESPONCE:\n", response, "\nERROR\n", error)
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 402 {
                    print( DataManager.shared.passNextApiKey()
                           ? "Next API key is installed"
                           : "API keys are out"
                    )
                }
                
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
