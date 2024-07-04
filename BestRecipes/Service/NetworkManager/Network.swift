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
    func fetchTrending(_ completion: @escaping (Result<[Recipe], NetworkError>) -> Void)
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


final class NetworkManager: NetworkService {
    
    //    static let shared = NetworkManager()
    
    //    private init() {}
    
    
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
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    //MARK: - Main Module
    
    func getMainURL() -> String {
        let url = "https://api.spoonacular.com/recipes/random?apiKey=94a3e904ec2d4cc8bab79ce9735f4d49&number=5&type=sort&sortDirection=desc&instructionsRequired=true"
        return url
    }
    
    
    func fetchTrending(_ completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let url = URL(string: getMainURL()) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(.failure(.noData))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(ResponseRecipe.self, from: data)
                let dataArray = responseObject.recipes
                completion(.success(dataArray))
            } catch {
                completion(.failure(.decodingError))
                print("error fetch trend")
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
