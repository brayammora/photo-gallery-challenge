//
//  MockHomeRouter.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import Foundation
@testable import photo_gallery_challenge

struct HomeRouterCalls {
    var didNavigateToDetail: Bool = false
}

class MockHomeRouter: HomeRouterInterface {
    lazy var calls = HomeRouterCalls()
    
    func navigate(to option: HomeNavigationOption) {
        switch option {
        case .detailPhoto:
            calls.didNavigateToDetail = true
        }
    }
}
