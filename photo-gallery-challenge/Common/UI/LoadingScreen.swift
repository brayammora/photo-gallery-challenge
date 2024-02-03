//
//  LoadingScreen.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit

fileprivate var containerLoading: UIView?

extension UIViewController {
    func showLoading () {
        containerLoading = UIView(frame: view.bounds)
        guard let containerLoading = containerLoading else {
            return
        }
        
        containerLoading.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = containerLoading.center
        activityIndicator.startAnimating()
        containerLoading.addSubview(activityIndicator)
        view.addSubview(containerLoading)
    }
    
    func hideLoading () {
        containerLoading?.removeFromSuperview()
        containerLoading = nil
    }
}
