//
//  CoreDataPhotoManager.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import CoreData

protocol LocalStorageService {
    func fetchPhotos(page: Int, pageSize: Int) throws -> [GalleryPhoto]
    func savePhotos(_ photos: [GalleryPhoto]) throws
    func saveOrUpdatePhoto(_ photos: [GalleryPhoto]) throws
    func deletePhoto(withId id: Int) throws
    func deleteAllData() throws
}

class CoreDataPhotoManager: LocalStorageService {
    
    private let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
    
    init() { }
    
    func fetchPhotos(page: Int, pageSize: Int) throws -> [GalleryPhoto] {
        let fetchRequest: NSFetchRequest<GalleryPhotoLocal> = GalleryPhotoLocal.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.fetchLimit = pageSize
        fetchRequest.fetchOffset = (page - 1) * pageSize
        
        do {
            let localPhotos = try managedObjectContext.fetch(fetchRequest)
            return localPhotos.map { localPhoto in
                GalleryPhoto(albumId: Int(localPhoto.albumId),
                             id: Int(localPhoto.id),
                             title: localPhoto.title ?? "",
                             url: localPhoto.url ?? "",
                             thumbnailUrl: localPhoto.thumbnailUrl ?? "")
            }
        } catch {
            throw CustomError.errorOnLocalStorage
        }
    }
    
    func savePhotos(_ photos: [GalleryPhoto]) throws {
        do {
            var photoLocalList: [GalleryPhotoLocal] = []
            for photo in photos {
                let photoLocal = GalleryPhotoLocal(context: managedObjectContext)
                photoLocal.albumId = Int32(photo.albumId)
                photoLocal.id = Int32(photo.id)
                photoLocal.title = photo.title
                photoLocal.url = photo.url
                photoLocal.thumbnailUrl = photo.thumbnailUrl
                photoLocalList.append(photoLocal)
            }
            try managedObjectContext.save()
        } catch {
            throw CustomError.errorOnLocalStorage
        }
    }
    
    func saveOrUpdatePhoto(_ photos: [GalleryPhoto]) throws {
        for photo in photos {
            // Find object
            let entityName = CoreDataEntity.galleryPhoto.rawValue
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %d", photo.id)
            
            do {
                if let existingObject = try managedObjectContext.fetch(fetchRequest).first as? NSManagedObject {
                    existingObject.setValue(photo.albumId, forKey: "albumId")
                    existingObject.setValue(photo.id, forKey: "id")
                    existingObject.setValue(photo.title, forKey: "title")
                    existingObject.setValue(photo.url, forKey: "url")
                    existingObject.setValue(photo.thumbnailUrl, forKey: "thumbnailUrl")
                } else {
                    // If object does'nt exists, creates a new one
                    let photoLocal = GalleryPhotoLocal(context: managedObjectContext)
                    photoLocal.albumId = Int32(photo.albumId)
                    photoLocal.id = Int32(photo.id)
                    photoLocal.title = photo.title
                    photoLocal.url = photo.url
                    photoLocal.thumbnailUrl = photo.thumbnailUrl
                }
                try managedObjectContext.save()
            } catch {
                throw CustomError.errorOnLocalStorage
            }
        }
    }
    
    func deletePhoto(withId id: Int) throws {
        let fetchRequest: NSFetchRequest<GalleryPhotoLocal> = GalleryPhotoLocal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        if let photoToDelete = try managedObjectContext.fetch(fetchRequest).first {
            managedObjectContext.delete(photoToDelete)
            try managedObjectContext.save()
        }
    }
    
    func deleteAllData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataEntity.galleryPhoto.rawValue)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            try managedObjectContext.save()
        } catch {
            throw CustomError.errorOnLocalStorage
        }
    }
}
