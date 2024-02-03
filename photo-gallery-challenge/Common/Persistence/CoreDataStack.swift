//
//  CoreDataStack.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import CoreData

enum CoreDataModelName: String {
    case photoGallery = "PhotoGalleryModel"
}

enum CoreDataEntity: String {
    case galleryPhoto = "GalleryPhotoLocal"
}

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataModelName.photoGallery.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error._userInfo as Any)")
            }
        })
        return container
    }()

    func setup() {
        _ = persistentContainer
    }

    func saveContext() async throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try await context.perform {
                try context.save()
            }
        }
    }
}
