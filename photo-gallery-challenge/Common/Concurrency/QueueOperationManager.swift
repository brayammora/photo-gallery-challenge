//
//  QueueOperationManager.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 5/02/24.
//

import Foundation
import Combine

class QueueOperationManager {
    static let shared = QueueOperationManager()
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        return queue
    }()

    func setup() {
        _ = queue
    }
    
    func addOperation(_ operation: Operation) {
        queue.addOperation(operation)
    }
}
