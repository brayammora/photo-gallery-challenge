//
//  DetailRouter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit

final class DetailRouter: BaseRouter {
    
    init(_ photo: GalleryPhoto) {
        let viewController = DetailViewController()
        super.init(viewController: viewController)
        let interactor = DetailInteractor(photo)
        let presenter = DetailPresenter(interactor: interactor, router: self, view: viewController)
        viewController.presenter = presenter
    }
}

// MARK: - DetailRouterInterface -
extension DetailRouter: DetailRouterInterface {
    func backToHome() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
