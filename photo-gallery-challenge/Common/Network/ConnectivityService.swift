//
//  ConnectivityService.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import Network

class ConnectivityService {
    static let shared = ConnectivityService()

    private let monitor = NWPathMonitor()

    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // Hay conexión a Internet
            } else {
                // No hay conexión a Internet
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
