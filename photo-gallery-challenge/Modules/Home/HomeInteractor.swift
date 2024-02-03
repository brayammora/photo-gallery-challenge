//
//  HomeInteractor.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import Foundation

typealias GalleryPhotoCompletion = (Result<[GalleryPhoto], CustomError>) -> Void

final class HomeInteractor {
    // MARK: - Private properties -
    private let serviceManager: BaseNetworkService
    private let localStorageManager: LocalStorageService
    private var currentPage: Int = 1
    
    init(serviceManager: BaseNetworkService = NetworkManager(),
         localStorageManager: LocalStorageService = CoreDataPhotoManager()) {
        self.serviceManager = serviceManager
        self.localStorageManager = localStorageManager
    }
}

// MARK: - HomeInteractorInterface -
extension HomeInteractor: HomeInteractorInterface {
    func getNextPage(completion: @escaping GalleryPhotoCompletion) {
        serviceManager.sendRequest(endpoint: .getPhotos(page: currentPage),
                                   of: [GalleryPhoto].self,
                                   method: .get) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let photos):
                self.currentPage += 1
                self.savePhotosToLocal(photos)
                completion(.success(photos))
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
}

// MARK: - Private Methods -
private extension HomeInteractor {
    func checkLocalStorage(_ completion: @escaping GalleryPhotoCompletion) {
        Task {
            let localPhotos = await self.getPhotosFromLocal()
            if !localPhotos.isEmpty {
                self.currentPage += 1
                completion(.success(localPhotos))
            } else {
                completion(.failure(.noData))
            }
        }
    }
    
    func getPhotosFromLocal() async -> [GalleryPhoto] {
        do {
            return try localStorageManager.fetchPhotos(page: currentPage, pageSize: 10)
        } catch {
            return []
        }
    }
    
    func savePhotosToLocal(_ photos: [GalleryPhoto]) {
        Task {
            do {
                try localStorageManager.saveOrUpdatePhoto(photos)
            } catch {
                print("error saving data")
            }
        }
    }
}
