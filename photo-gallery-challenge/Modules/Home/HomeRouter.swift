//
//  HomeRouter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import UIKit

final class HomeRouter {
    private var navigationController: UINavigationController?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, router: self, view: viewController)
        viewController.presenter = presenter
        navigation.pushViewController(viewController, animated: false)
    }
}

// MARK: - HomeRouterInterface -
extension HomeRouter: HomeRouterInterface {
    func navigate(to option: HomeNavigationOption) {
        
    }
}
