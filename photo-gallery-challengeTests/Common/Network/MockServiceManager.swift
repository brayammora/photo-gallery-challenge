//
//  MockServiceManager.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import Foundation
@testable import photo_gallery_challenge

class MockServiceManager: BaseNetworkService {
    var shouldRetrieveData: Bool = false
    
    func sendRequest<T: Codable>(endpoint: Endpoint, of type: T.Type, method: HTTPMethod, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        if shouldRetrieveData {
            switch type {
            case is [GalleryPhoto].Type:
                guard let response = generatePhotosResponse() as? T else {
                    completion(.failure(.responseError))
                    return
                }
                completion(.success(response))
            default:
                completion(.failure(.unableToParse))
            }
        } else {
            completion(.failure(.responseError))
        }
    }
    
    private func generatePhotosResponse() -> [GalleryPhoto] {
        let bundle = Bundle(for: MockServiceManager.self)
        guard let model: [GalleryPhoto] = FileManager.getJSONObject(from: "GalleryPhoto", bundle: bundle)
        else {
            return []
        }
        return model
    }
}
