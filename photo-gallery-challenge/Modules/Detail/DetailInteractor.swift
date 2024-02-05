//
//  DetailInteractor.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import Foundation
import Combine

final class DetailInteractor {
    
    // MARK: - Private properties -
    private let photo: GalleryPhoto
    private let serviceManager: BaseNetworkService
    private let localStorageManager: LocalStorageService
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ photo: GalleryPhoto,
         serviceManager: BaseNetworkService = NetworkManager(),
         localStorageManager: LocalStorageService = CoreDataPhotoManager()) {
        self.photo = photo
        self.serviceManager = serviceManager
        self.localStorageManager = localStorageManager
    }
}

// MARK: - DetailInteractorInterface -
extension DetailInteractor: DetailInteractorInterface {
    var id: Int { photo.id }
    var title: String { photo.title }
    var url: String { photo.url }
    
    func deletePhoto(wasDeletedCompletion: @escaping (Bool) -> Void) {
        serviceManager.sendRequest(endpoint: .deletePhoto(id: id),
                                   of: VoidRequest.self,
                                   method: .delete) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.deleteLocalPhoto()
                wasDeletedCompletion(true)
            case .failure:
                self.queueDeleteOperation()
                wasDeletedCompletion(false)
                break
            }
        }
    }
    
    func deletePhotoWithoutQueue() {
        serviceManager.sendRequest(endpoint: .deletePhoto(id: id),
                                   of: VoidRequest.self,
                                   method: .delete) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.deleteLocalPhoto()
            case .failure:
                break
            }
        }
    }
    
    private func deleteLocalPhoto() {
        do {
            try self.localStorageManager.deletePhoto(withId: self.id)
        } catch {
            print("Cannot delete local photo")
        }
    }
    
    private func queueDeleteOperation() {
        let operation = BlockOperation { [weak self] in
            guard let self = self else { return }
            ConnectivityService.shared.completionPublisher
                .sink { _ in
                    self.deletePhotoWithoutQueue()
                }
                .store(in: &self.cancellables)
        }
        QueueOperationManager.shared.addOperation(operation)
    }
}
