//
//  WeakRef+SearchPhotoBusinessUseCaseOutput.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 22/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
extension WeakRef: SearchPhotoBusinessLogicUseCaseOutPut where T: SearchPhotoBusinessLogicUseCaseOutPut {
    func didSearch(_ items: [Picture]) {
        object?.didSearch(items)
    }

    func didGetSearchError(_ errr: Error) {
        object?.didGetSearchError(errr)
    }

}
