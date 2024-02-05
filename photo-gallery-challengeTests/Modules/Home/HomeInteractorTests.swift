//
//  HomeInteractorTests.swift
//  photo-gallery-challengeTests
//
//  Created by Brayam Mora on 4/02/24.
//

import XCTest
@testable import photo_gallery_challenge

class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor?
    let mockServiceManager = MockServiceManager()
    let mockLocalStorageManager = MockLocalStorageManager()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeInteractor(serviceManager: mockServiceManager, localStorageManager: mockLocalStorageManager)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_getData_WhenSucessResponse_ThenResultCompletionBringsData() {
        // Given
        let expectation = self.expectation(description: "Fetching all movies")
        mockServiceManager.shouldRetrieveData = true
        // When
        sut?.getNextPage { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                XCTAssert(self.mockLocalStorageManager.calls.didSaveOrUpdatePhoto)
                XCTAssert(!data.isEmpty)
                expectation.fulfill()
            case .failure:
                XCTFail("Must bring data")
            }
        }
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
