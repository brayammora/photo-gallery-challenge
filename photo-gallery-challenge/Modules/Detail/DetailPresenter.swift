//
//  DetailPresenter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import Foundation

final class DetailPresenter {
    // MARK: - Private properties -
    private let interactor: DetailInteractorInterface
    private let router: DetailRouterInterface
    private weak var view: DetailViewInterface?
    private var sections: [DetailSection] = DetailSection.allCases
    
    init(interactor: DetailInteractorInterface, router: DetailRouterInterface, view: DetailViewInterface) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

// MARK: - DetailPresenterInterface -
extension DetailPresenter: DetailPresenterInterface {
    var numberOfItemsInSection: Int { 1 }
    var numberOfSections: Int { sections.count }
    
    func didLoad() {
        view?.reloadData()
    }
    
    func getItem(at indexPath: IndexPath) -> DetailTableViewSection? {
        guard indexPath.section < sections.count else { return nil }
        let section = sections[indexPath.section]
        switch section {
        case .image:
            return .image(model: DetailImageViewModel(url: interactor.url))
        case .id:
            return .info(model: DetailInfoViewModel(title: section.titleHeader, content: String(interactor.id)))
        case .title:
            return .info(model: DetailInfoViewModel(title: section.titleHeader, content: interactor.title))
        case .deleteButton:
            return .deleteButtton(model: DetailButtonViewModel(buttonText: section.titleHeader))
        }
    }
}
