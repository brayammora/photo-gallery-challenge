//
//  GalleryPhoto.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import Foundation

struct GalleryPhoto: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
