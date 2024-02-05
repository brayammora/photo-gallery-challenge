//
//  HomeInteractor.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import Foundation

typealias GalleryPhotoCompletion = (Result<Void, CustomError>) -> Void

final class HomeInteractor {
    // MARK: - Private properties -
    private let serviceManager: BaseNetworkService
    private let localStorageManager: LocalStorageService
    private var currentPage: Int = 1
    private var photos: [GalleryPhoto] = []
    
    init(serviceManager: BaseNetworkService = NetworkManager(),
         localStorageManager: LocalStorageService = CoreDataPhotoManager()) {
        self.serviceManager = serviceManager
        self.localStorageManager = localStorageManager
    }
}

// MARK: - HomeInteractorInterface -
extension HomeInteractor: HomeInteractorInterface {
    var photoList: [GalleryPhoto] { photos }
    
    func getNextPage(completion: @escaping GalleryPhotoCompletion) {
        serviceManager.sendRequest(endpoint: .getPhotos(page: currentPage),
                                   of: [GalleryPhoto].self,
                                   method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let servicePhotos):
                self.currentPage += 1
                self.savePhotosToLocal(servicePhotos)
                if self.photos.isEmpty {
                    self.photos = servicePhotos
                } else {
                    self.photos += servicePhotos
                }
                completion(.success(()))
            case .failure:
                self.checkLocalStorage(completion)
            }
        }
    }
    
    func deleteAllLocalRecords() {
        do {
            try localStorageManager.deleteAllData()
        } catch {
            print("error deleting data")
        }
        
    }
    
    func resetFromInit() {
        currentPage = 1
    }
}

// MARK: - Private Methods -
private extension HomeInteractor {
    func checkLocalStorage(_ completion: @escaping GalleryPhotoCompletion) {
        let localPhotos = self.getPhotosFromLocal()
        if !localPhotos.isEmpty {
            self.currentPage += 1
            self.photos = localPhotos
            completion(.success(()))
        } else {
            completion(.failure(.noData))
        }
    }
    
    func getPhotosFromLocal() -> [GalleryPhoto] {
        do {
            return try localStorageManager.fetchPhotos(page: currentPage, pageSize: 10)
        } catch {
            return []
        }
    }
    
    func savePhotosToLocal(_ photos: [GalleryPhoto]) {
        do {
            try localStorageManager.saveOrUpdatePhoto(photos)
        } catch {
            print("error saving data")
        }
    }
}
