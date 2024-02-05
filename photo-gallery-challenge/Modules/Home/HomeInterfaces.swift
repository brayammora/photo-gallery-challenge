//
//  HomeInterfaces.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import Foundation

protocol HomeInteractorInterface {
    var photoList: [GalleryPhoto] { get }
    func getNextPage(completion: @escaping GalleryPhotoCompletion)
    func deleteAllLocalRecords()
    func resetFromInit()
}

protocol HomeRouterInterface {
    func navigate(to option: HomeNavigationOption)
}

protocol HomePresenterInterface {
    var title: String { get}
    var deleteButtonText: String { get }
    var numberOfItems: Int { get }
    func getNextPage()
    func getItem(at indexPath: IndexPath) -> PhotoViewModel?
    func didSelectItem(at indexPath: IndexPath)
    func deleteAllLocalRecords()
}

protocol HomeViewInterface: AnyObject {
    func reloadData()
    func didGetError(_ message: String)
    func showLoader()
    func hideLoader()
}

enum HomeNavigationOption {
    case detailPhoto(photo: GalleryPhoto)
}

enum HomeStrings {
    static let title = "Photo Gallery"
    static let deleteButtonText = "Delete local records"
}
