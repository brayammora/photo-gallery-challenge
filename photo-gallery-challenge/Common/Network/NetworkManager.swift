//
//  NetworkManager.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import Foundation

final class NetworkManager: BaseNetworkService {
    func sendRequest<T: Codable>(endpoint: Endpoint, of: T.Type, method: HTTPMethod, completion: @escaping (Result<T, CustomError>) -> Void) {
        let finalPath = "\(NetworkConstants.baseUrl)\(endpoint.path)"
        guard let url = URL(string: finalPath) else {
            completion(.failure(.badUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.noInternetConnection))
                return
            }
            
            guard let data = data else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
}
