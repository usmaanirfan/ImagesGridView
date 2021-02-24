//
//  PhotoBusinessLogicUseCase.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

protocol PhotoBusinessLogicUseCaseOutput {
    func didFetch(_ items: [Picture])
    func didGetError(_ errr: Error)
}

class PhotoBusinessLogicUseCase {

    var items = [Any]()
    var currentPage : Page
    let networkRequest : NetworkRequestInterface
    let photoBusinessLogicUseCaseOutput : PhotoBusinessLogicUseCaseOutput

    convenience init(networkRequest : NetworkRequestInterface, photoBusinessLogicUseCaseOutput : PhotoBusinessLogicUseCaseOutput) {
        let page = Page(pageNumber: 1, numberOfItems: 30)
        self.init(with: page, networkRequest: networkRequest, photoBusinessLogicUseCaseOutput : photoBusinessLogicUseCaseOutput)
    }

    init(with page: Page, networkRequest : NetworkRequestInterface, photoBusinessLogicUseCaseOutput : PhotoBusinessLogicUseCaseOutput) {
        self.currentPage = page
        self.networkRequest = networkRequest
        self.photoBusinessLogicUseCaseOutput = photoBusinessLogicUseCaseOutput
    }

    func nextPage() -> Page {
        return Page(pageNumber: self.currentPage.pageNumber + 1, numberOfItems: self.currentPage.numberOfItems)
    }

    func fetch() {
        let parameters = prepareParameters()
        networkRequest.fetchPhotoDetails(dataType: [Picture].self, requestType: .fetchPhotos, with: parameters) { result in
            switch result {
            case .success(let pictures):
                self.photoBusinessLogicUseCaseOutput.didFetch(pictures)
                self.currentPage = self.nextPage()
            case .failure(let error):
                self.photoBusinessLogicUseCaseOutput.didGetError(error)
            }
        }
    }

    func prepareParameters() -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["page"] = currentPage.pageNumber
        parameters["per_page"] = currentPage.numberOfItems
        return parameters
    }

}
