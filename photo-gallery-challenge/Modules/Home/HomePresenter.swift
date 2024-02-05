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
    var numberOfItems: Int { interactor.photoList.count }
    
    func getNextPage() {
        view?.showLoader()
        interactor.getNextPage() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.view?.reloadData()
            case .failure(let error):
                print(error)
                if self.interactor.photoList.isEmpty {
                    self.view?.didGetError(ErrorStrings.defaultMessage)
                }
            }
            self.view?.hideLoader()
        }
    }
    
    func getItem(at indexPath: IndexPath) -> PhotoViewModel? {
        guard indexPath.row < interactor.photoList.count else { return nil }
        let photo = interactor.photoList[indexPath.row]
        let shortTitle = String(photo.title.prefix(5))
        return PhotoViewModel(title: shortTitle, thumbnailUrl: photo.thumbnailUrl)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.row < interactor.photoList.count else { return }
        let photoSelected = interactor.photoList[indexPath.row]
        router.navigate(to: .detailPhoto(photo: photoSelected))
    }
    
    func deleteAllLocalRecords() {
        interactor.deleteAllLocalRecords()
    }
}
