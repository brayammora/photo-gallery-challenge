//
//  DetailInterfaces.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import Foundation

protocol DetailRouterInterface { }

protocol DetailInteractorInterface {
    var id: Int { get }
    var title: String { get }
    var url: String { get }
}

protocol DetailPresenterInterface {
    var numberOfItemsInSection: Int { get }
    var numberOfSections: Int { get }
    func didLoad()
    func getItem(at indexPath: IndexPath) -> DetailTableViewSection?
}

protocol DetailViewInterface: AnyObject {
    func reloadData()
}

enum DetailTableViewSection {
    case image(model: DetailImageViewModel)
    case info(model: DetailInfoViewModel)
    case deleteButtton(model: DetailButtonViewModel)
}

enum DetailSection: CaseIterable {
    case image
    case id
    case title
    case deleteButton
    
    var titleHeader: String {
        switch self {
        case .id:
            return DetailStrings.id
        case .title:
            return DetailStrings.title
        case .deleteButton:
            return DetailStrings.deleteButton
        default:
            return ""
        }
    }
}

enum DetailStrings {
    static let id = "Id:"
    static let title = "Title for this image:"
    static let deleteButton = "Delete"
}
