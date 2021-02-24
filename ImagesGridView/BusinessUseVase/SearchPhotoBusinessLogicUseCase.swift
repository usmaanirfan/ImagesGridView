//
//  SearchPhotoBusinessLogicUseCase.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
import Foundation

protocol SearchPhotoBusinessLogicUseCaseOutPut {
    func didSearch(_ items: [Picture])
    func didGetSearchError(_ errr: Error)
}

class SearchPhotoBusinessLogicUseCase {

    var items = [Any]()
    var currentPage : Page
    let networkRequest : NetworkRequestInterface
    let searchPhotoBusinessLogicUseCaseOutPut : SearchPhotoBusinessLogicUseCaseOutPut

    convenience init(networkRequest : NetworkRequestInterface, searchPhotoBusinessLogicUseCaseOutPut : SearchPhotoBusinessLogicUseCaseOutPut) {
        let page = Page(pageNumber: 1, numberOfItems: 30)
        self.init(with: page, networkRequest: networkRequest, searchPhotoBusinessLogicUseCaseOutPut : searchPhotoBusinessLogicUseCaseOutPut)
    }

    init(with page: Page, networkRequest : NetworkRequestInterface, searchPhotoBusinessLogicUseCaseOutPut : SearchPhotoBusinessLogicUseCaseOutPut) {
        self.currentPage = page
        self.networkRequest = networkRequest
        self.searchPhotoBusinessLogicUseCaseOutPut = searchPhotoBusinessLogicUseCaseOutPut
    }

    func nextPage() -> Page {
        return Page(pageNumber: self.currentPage.pageNumber + 1, numberOfItems: self.currentPage.numberOfItems)
    }

    func search(with query : String, isStart: Bool = false) {
        if isStart ==  true {
            self.currentPage = Page(pageNumber: 1, numberOfItems: 30)
        }
        let parameters = prepareParameters(query : query)
        networkRequest.fetchPhotoDetails(dataType: SeacrhItem.self, requestType: .searchPhotos, with: parameters) { result in
            switch result {
            case .success(let item):
                let results = item.results
                self.searchPhotoBusinessLogicUseCaseOutPut.didSearch(results)
                self.currentPage = self.nextPage()
            case .failure(let error):
                self.searchPhotoBusinessLogicUseCaseOutPut.didGetSearchError(error)
            }
        }
    }

    func prepareParameters(query : String) -> [String: Any]? {
        var parameters = [String: Any]()
        parameters["page"] = currentPage.pageNumber
        parameters["per_page"] = currentPage.numberOfItems
        parameters["query"] = query
        return parameters
    }


}
