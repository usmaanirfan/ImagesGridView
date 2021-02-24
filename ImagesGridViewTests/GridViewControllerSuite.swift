//
//  GridViewControllerSuite.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 24/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import XCTest
@testable import ImagesGridView

class GridViewControllerSuite: XCTestCase {

    var gridViewController: GridViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.gridViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gridViewController") as? GridViewController
        _ = gridViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCollectionViewShouldNotBeNil() {
        XCTAssertNotNil(self.gridViewController.collectionView)
    }

    func testCollectionDataSourceViewDataSource(){
        XCTAssertNotNil(self.gridViewController.collectionView.dataSource)
    }

    func testCollectionDataSourceViewDelegate() {
        XCTAssertNotNil(self.gridViewController.collectionView.delegate)
    }

    func testViewNumberOfSections() {
        XCTAssertEqual(self.gridViewController.collectionView.numberOfSections, 1)
    }

}
