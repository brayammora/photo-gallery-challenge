//
//  BaseRouter.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit

class BaseRouter {

    var viewController: UIViewController
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
