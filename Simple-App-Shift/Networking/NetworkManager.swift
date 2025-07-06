//
//  Networking.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkingError(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .noData:
            return "Нет данных"
        case .decodingError:
            return "Ошибка декодирования данных"
        case .serverError(let message):
            return "Ошибка сервера: \(message)"
        case .networkingError(let error):
            return "Ошибка сети: \(error.localizedDescription)"
        }
    }
}

protocol NetworkManagerProtocol {
    func fetchData(completion: @escaping (Result<[ModelFakeStore], NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func fetchData(completion: @escaping (Result<[ModelFakeStore], NetworkError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "fakestoreapi.com"
        urlComponents.path = "/products"
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(.networkingError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let fetch = try JSONDecoder().decode([ModelFakeStore].self, from: data)
                completion(.success(fetch))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
