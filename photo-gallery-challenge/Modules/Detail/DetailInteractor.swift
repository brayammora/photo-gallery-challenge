//
//  DetailInteractor.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import Foundation

final class DetailInteractor {
    
    let photo: GalleryPhoto
    
    init(_ photo: GalleryPhoto) {
        self.photo = photo
    }
}

// MARK: - DetailInteractorInterface -
extension DetailInteractor: DetailInteractorInterface {
    var id: Int { photo.id }
    var title: String { photo.title }
    var url: String { photo.url }
}
