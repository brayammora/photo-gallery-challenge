//
//  MockLocalStorageManager.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import Foundation
@testable import photo_gallery_challenge

struct LocalStorageCalls {
    var didFetchPhotos: Bool = false
    var didSavePhotos: Bool = false
    var didSaveOrUpdatePhoto: Bool = false
    var didDeletePhoto: Bool = false
    var didDeleteAllData: Bool = false
}

class MockLocalStorageManager: LocalStorageService {
    lazy var calls = LocalStorageCalls()
    var shouldRetrieveData: Bool = false
    
    func fetchPhotos(page: Int, pageSize: Int) throws -> [GalleryPhoto] {
        calls.didFetchPhotos = true
        if shouldRetrieveData {
            let response = generatePhotosResponse()
            return response
        } else {
          return []
        }
    }
    
    func savePhotos(_ photos: [GalleryPhoto]) throws {
        calls.didSavePhotos = true
    }
    
    func saveOrUpdatePhoto(_ photos: [GalleryPhoto]) throws {
        calls.didSaveOrUpdatePhoto = true
    }
    
    func deletePhoto(withId id: Int) throws {
        calls.didDeletePhoto = true
    }
    
    func deleteAllData() throws {
        calls.didDeleteAllData = true
    }
    
    private func generatePhotosResponse() -> [GalleryPhoto] {
        let bundle = Bundle(for: MockServiceManager.self)
        guard let model: [GalleryPhoto] = FileManager.getJSONObject(from: "GalleryPhoto", bundle: bundle)
        else { return [] }
        return model
    }
}
