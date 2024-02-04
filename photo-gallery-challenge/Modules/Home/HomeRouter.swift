//
//  HomeRouter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import UIKit

final class HomeRouter: BaseRouter {
    
    init() {
        let viewController = HomeViewController()
        super.init(viewController: viewController)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, router: self, view: viewController)
        viewController.presenter = presenter
    }
}

// MARK: - HomeRouterInterface -
extension HomeRouter: HomeRouterInterface {
    func navigate(to option: HomeNavigationOption) {
        switch option {
        case .detailPhoto(let photo):
            let detailRouter = DetailRouter(photo)
            navigationController?.pushViewController(detailRouter.viewController, animated: true)
        }
    }
}
