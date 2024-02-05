//
//  MockHomeView.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import Foundation
@testable import photo_gallery_challenge

struct HomeViewCalls {
    var didGetError: Bool = false
    var didHideLoader: Bool = false
    var didShowLoader: Bool = false
    var didReloadData: Bool = false
}

class MockHomeView: HomeViewInterface {
    lazy var calls = HomeViewCalls()
    
    func didGetError(_ message: String) {
        calls.didGetError = true
    }
    func hideLoader() {
        calls.didHideLoader = true
    }
    func showLoader() {
        calls.didShowLoader = true
    }
    func reloadData() {
        calls.didReloadData = true
    }
}
