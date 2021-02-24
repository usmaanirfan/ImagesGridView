//
//  SearchPhotoBusinessLogicUseCaseSuite.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import XCTest
@testable import ImagesGridView

class SearchPhotoBusinessLogicUseCaseSuite: XCTestCase {
    var searchPhotoBusinessLogicUseCase : SearchPhotoBusinessLogicUseCase?
    private var urlSessionMock: URLSessionMock!
    var networkRequest : NetworkRequest!
    override func setUp() {
        urlSessionMock = URLSessionMock()
        networkRequest = NetworkRequest(session: urlSessionMock)
    }

    override func tearDown() {

    }

    func testFetch() {
        let output = OutputSpy()
        searchPhotoBusinessLogicUseCase = SearchPhotoBusinessLogicUseCase(networkRequest: networkRequest, searchPhotoBusinessLogicUseCaseOutPut: WeakRef(output))
        //When
        searchPhotoBusinessLogicUseCase?.search(with: "Ali")
        //Then
        XCTAssertGreaterThan(output.photos.count, 0, "Should have generated at least 0")
    }

    func testNextPage() {
        let output = OutputSpy()
        searchPhotoBusinessLogicUseCase = SearchPhotoBusinessLogicUseCase(networkRequest: networkRequest, searchPhotoBusinessLogicUseCaseOutPut: WeakRef(output))
        //When
        let next = searchPhotoBusinessLogicUseCase?.nextPage()
        //Then
        XCTAssertGreaterThan(next!.pageNumber, 0, "Should have generated at least 0")
    }

    func testPrepairParameter() {
        let output = OutputSpy()
        searchPhotoBusinessLogicUseCase = SearchPhotoBusinessLogicUseCase(networkRequest: networkRequest, searchPhotoBusinessLogicUseCaseOutPut: WeakRef(output))
        //When
        let parameter = searchPhotoBusinessLogicUseCase?.prepareParameters(query: "Ali")
        //Then
        XCTAssertNotNil(parameter)
    }

    private class OutputSpy: SearchPhotoBusinessLogicUseCaseOutPut {
        var photos = [Picture]()
        func didSearch(_ items: [Picture]) {
            photos.append(contentsOf: items)

        }

        func didGetSearchError(_ errr: Error) {

        }
    }

}
