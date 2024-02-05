//
//  MockHomeInteractor.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import Foundation
@testable import photo_gallery_challenge

struct HomeInteractorCalls {
    var didGetNextPage: Bool = false
    var didGetNextPageError: Bool = false
    var didDeleteAllLocalRecords: Bool = false
}

class MockHomeInteractor: HomeInteractorInterface {
    lazy var calls = HomeInteractorCalls()
    lazy var photos: [GalleryPhoto] = []
    
    func getNextPage(completion: @escaping GalleryPhotoCompletion) {
        if !photos.isEmpty {
            calls.didGetNextPage = true
            completion(.success(photos))
        } else {
            calls.didGetNextPageError = true
            completion(.failure(.responseError))
        }
    }
    
    func deleteAllLocalRecords() {
        calls.didDeleteAllLocalRecords = true
    }
}
