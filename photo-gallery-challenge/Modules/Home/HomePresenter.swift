//
//  HomePresenter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import Foundation

final class HomePresenter {
    // MARK: - Private properties -
    private let interactor: HomeInteractorInterface
    private let router: HomeRouterInterface
    private weak var view: HomeViewInterface?
    private var photoList: [GalleryPhoto] = []
    
    init(interactor: HomeInteractorInterface, router: HomeRouterInterface, view: HomeViewInterface) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

// MARK: - HomePresenterInterface -
extension HomePresenter: HomePresenterInterface {
    var title: String { HomeStrings.title }
    var deleteButtonText: String { HomeStrings.deleteButtonText }
    var numberOfItems: Int { photoList.count }
    
    func getNextPage() {
        view?.showLoader()
        interactor.getNextPage() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let photos):
                self.photoList += photos
                self.view?.reloadData()
            case .failure(let error):
                print(error)
                if self.photoList.isEmpty {
                    self.view?.didGetError(ErrorStrings.defaultMessage)
                }
            }
            self.view?.hideLoader()
        }
    }
    
    func getItem(at indexPath: IndexPath) -> PhotoViewModel? {
        guard indexPath.row < photoList.count else { return nil }
        let photo = photoList[indexPath.row]
        let shortTitle = String(photo.title.prefix(5))
        return PhotoViewModel(title: shortTitle, thumbnailUrl: photo.thumbnailUrl)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.row < photoList.count else { return }
        let photoSelected = photoList[indexPath.row]
        router.navigate(to: .detailPhoto(photo: photoSelected))
    }
    
    func deleteAllLocalRecords() {
        interactor.deleteAllLocalRecords()
    }
}
