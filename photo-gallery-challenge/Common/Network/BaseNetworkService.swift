//
//  BaseNetworkService.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import Foundation

protocol BaseNetworkService {
    func sendRequest<T: Codable>(endpoint: Endpoint, of: T.Type, method: HTTPMethod, completion: @escaping (Result<T, CustomError>) -> Void)
}

enum NetworkConstants {
    static let baseUrl: String = "https://jsonplaceholder.typicode.com/"
}

enum Endpoint {
    case getPhotos(page: Int)
    
    var path: String {
        switch self {
        case .getPhotos(let page):
            return "photos?_page=\(page)"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case delete = "DELETE"
}

enum CustomError: Error {
    case badUrl
    case responseError
    case unableToParse
    case noInternetConnection
    case noData
    case errorOnLocalStorage
}
