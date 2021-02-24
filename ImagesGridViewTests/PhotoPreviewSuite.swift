//
//  PhotoPreviewSuite.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 24/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import XCTest
@testable import ImagesGridView

class PhotoPreviewSuite: XCTestCase {

    var photoPreviewViewController: PhotoPreviewViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.photoPreviewViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "photoPreviewViewController") as? PhotoPreviewViewController
        _ = photoPreviewViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPreviewImageShouldNotBeNil() {
        XCTAssertNotNil(self.photoPreviewViewController.regularImage)
    }

    func testIndiocatorShouldNotBeNil(){
        XCTAssertNotNil(self.photoPreviewViewController.activityIndicator)
    }

}
