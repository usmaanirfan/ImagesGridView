//
//  PhotoBusinessLogicUseCaseSuite.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//
import XCTest
@testable import ImagesGridView

class PhotoBusinessLogicUseCaseSuite: XCTestCase {
    var photoBusinessLogicUseCase: PhotoBusinessLogicUseCase?
    private var urlSessionMock: URLSessionMock!
    var networkRequest : NetworkRequest!
    override func setUp() {
        urlSessionMock = URLSessionMock()
        networkRequest = NetworkRequest(session: urlSessionMock)
    }

    override func tearDown() {

    }

    func testFetch() {
        //Given
        let output = OutputSpy()
        photoBusinessLogicUseCase = PhotoBusinessLogicUseCase(networkRequest: networkRequest, photoBusinessLogicUseCaseOutput: WeakRef(output))
        //When
        photoBusinessLogicUseCase?.fetch()
        //Then
        XCTAssertGreaterThan(output.photos.count, 0, "Should have generated at least 0")
    }

    func testNextPage() {
        let output = OutputSpy()
        photoBusinessLogicUseCase = PhotoBusinessLogicUseCase(networkRequest: networkRequest, photoBusinessLogicUseCaseOutput: WeakRef(output))
        //When
        let next = photoBusinessLogicUseCase?.nextPage()
        //Then
        XCTAssertGreaterThan(next!.pageNumber, 0, "Should have generated at least 0")
    }

    func testPrepairParameter() {
        let output = OutputSpy()
        photoBusinessLogicUseCase = PhotoBusinessLogicUseCase(networkRequest: networkRequest, photoBusinessLogicUseCaseOutput: WeakRef(output))
        //When
        let parameter = photoBusinessLogicUseCase?.prepareParameters()
        //Then
        XCTAssertNotNil(parameter)
    }

    private class OutputSpy: PhotoBusinessLogicUseCaseOutput {
        var photos = [Picture]()
        func didFetch(_ items: [Picture]) {
            photos.append(contentsOf: items)
        }

        func didGetError(_ errr: Error) {

        }
    }

}
