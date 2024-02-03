//
//  GalleryPhotoLocal+CoreDataProperties.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//
//

import Foundation
import CoreData


extension GalleryPhotoLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GalleryPhotoLocal> {
        return NSFetchRequest<GalleryPhotoLocal>(entityName: "GalleryPhotoLocal")
    }

    @NSManaged public var id: Int32
    @NSManaged public var albumId: Int32
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnailUrl: String?

}

extension GalleryPhotoLocal : Identifiable {

}
