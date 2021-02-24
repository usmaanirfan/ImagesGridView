//
//  PhotoGridViewPreseneterSuite.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
import XCTest
@testable import ImagesGridView

class PhotoGridViewPreseneterSuite: XCTestCase {
    var photoGridViewPreseneter: PhotoGridViewPreseneter?
    var photoBusinessLogicUseCase: PhotoBusinessLogicUseCase?
    var searchBusinessLogicUseCase: SearchPhotoBusinessLogicUseCase?

    private var outputSpy: OutputSpy!
    private var urlSessionMock: URLSessionMock!
    var networkRequest : NetworkRequest!

    override func setUp() {
        urlSessionMock = URLSessionMock()
        networkRequest = NetworkRequest(session: urlSessionMock)
        outputSpy = OutputSpy()
        photoGridViewPreseneter = PhotoGridViewPreseneter(photoGridViewPreseneterOuput: WeakRef(outputSpy))
        photoBusinessLogicUseCase = PhotoBusinessLogicUseCase(networkRequest: networkRequest, photoBusinessLogicUseCaseOutput: WeakRef(photoGridViewPreseneter!))
        searchBusinessLogicUseCase = SearchPhotoBusinessLogicUseCase(networkRequest: networkRequest, searchPhotoBusinessLogicUseCaseOutPut: WeakRef(photoGridViewPreseneter!))
        photoGridViewPreseneter?.fetchPhotos = photoBusinessLogicUseCase?.fetch
        photoGridViewPreseneter?.searchPhotos = searchBusinessLogicUseCase?.search
    }

    override func tearDown() {

    }

    func testFetch() {
        //Given
        //When
        photoGridViewPreseneter?.reloadData()
        //Then
        XCTAssertGreaterThan(outputSpy.photos.count, 0, "Should have generated at least 0")
    }

    func testSearch() {
        //Given
        //When
        photoGridViewPreseneter?.searchItem(text: "Ali")
        //Then
        XCTAssertGreaterThan(outputSpy.photos.count, 0, "Should have generated at least 0")
    }


    private class OutputSpy: PhotoGridViewPreseneterOuput {
        var photos = [Picture]()
        func fetchDidComplete(withPictures: [Picture]) {
            photos.append(contentsOf: withPictures)
        }

        func fetchFailure(withError: Error) {

        }
    }

}
