//
//  NetworkManager.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import Foundation

extension NetworkManager {
    enum NetworkError: Error {
        case invalidResponse
        case invalidData
        case error(message: String)
        case decodingError(message: String)
    }
}

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.error(message: error?.localizedDescription ?? "Network error")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let error {
                completion(.failure(.decodingError(message: error.localizedDescription)))
            }
        }.resume()
    }
}

