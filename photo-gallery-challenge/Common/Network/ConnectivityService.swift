//
//  ConnectivityService.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import Network
import Combine

class ConnectivityService {
    static let shared = ConnectivityService()
    private let subject = PassthroughSubject<Void, Never>()
    private let monitor = NWPathMonitor()

    var completionPublisher: AnyPublisher<Void, Never> {
        return subject.eraseToAnyPublisher()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                self.subject.send()
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
