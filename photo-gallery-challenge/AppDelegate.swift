//
//  AppDelegate.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // start CoreData
        CoreDataStack.shared.setup()
        // start Connectivity monitor
        ConnectivityService.shared.startMonitoring()
        // start Queue manager
        QueueOperationManager.shared.setup()
        return true
    }
}
