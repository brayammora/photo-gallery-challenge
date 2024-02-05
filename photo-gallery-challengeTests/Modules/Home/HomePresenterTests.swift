//
//  HomePresenterTests.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import XCTest
@testable import photo_gallery_challenge

class HomePresenterTests: XCTestCase {

    var sut: HomePresenter?
    let interactor = MockHomeInteractor()
    let router = MockHomeRouter()
    let view = MockHomeView()

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomePresenter(interactor: interactor, router: router, view: view)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_getNextPage_WhenSucessResponse_ThenCheckPhotosCount() {
        // Given
        let photos = [
            GalleryPhoto(albumId: 1, id: 1, title: "First photo", url: "http://", thumbnailUrl: "http://")
        ]
        interactor.photos = photos
        // When
        sut?.getNextPage()
        // Then
        XCTAssertTrue(interactor.calls.didGetNextPage)
        XCTAssertEqual(sut?.numberOfItems, 1)
    }
    
    func test_getNextPage_WhenFailureResponse_ThenGetError() {
        // Given
        interactor.photos = []
        // When
        sut?.getNextPage()
        // Then
        XCTAssertTrue(interactor.calls.didGetNextPageError)
        XCTAssertTrue(view.calls.didGetError)
    }
    
    func test_getItem_WhenIndexPathIsValid_ThenGetModel() {
        // Given
        let photos = [
            GalleryPhoto(albumId: 1, id: 1, title: "First photo", url: "http://", thumbnailUrl: "http://")
        ]
        let mockIndexPath = IndexPath(row: 0, section: 0)
        interactor.photos = photos
        // When
        sut?.getNextPage()
        let viewModel = sut?.getItem(at: mockIndexPath)
        // Then
        XCTAssertNotNil(viewModel)
    }
    
    func test_getItem_WhenIndexPathIsNotValid_ThenGetNothing() {
        // Given
        let photos = [
            GalleryPhoto(albumId: 1, id: 1, title: "First photo", url: "http://", thumbnailUrl: "http://")
        ]
        let mockIndexPath = IndexPath(row: 5, section: 0)
        interactor.photos = photos
        // When
        sut?.getNextPage()
        let viewModel: PhotoViewModel? = sut?.getItem(at: mockIndexPath)
        // Then
        XCTAssertNil(viewModel)
    }
    
    func test_didSelectItem_WhenIndexPathIsValid_ThenItsRoutedToNextView() {
        // Given
        let photos = [
            GalleryPhoto(albumId: 1, id: 1, title: "First photo", url: "http://", thumbnailUrl: "http://")
        ]
        let mockIndexPath = IndexPath(row: 0, section: 0)
        interactor.photos = photos
        // When
        sut?.getNextPage()
        sut?.didSelectItem(at: mockIndexPath)
        // Then
        XCTAssertTrue(router.calls.didNavigateToDetail)
    }
}
