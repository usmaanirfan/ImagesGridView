//
//  WeakRef+PhotoBusinessUseCaseOutput.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
extension WeakRef: PhotoBusinessLogicUseCaseOutput where T: PhotoBusinessLogicUseCaseOutput {
    func didFetch(_ items: [Picture]) {
        object?.didFetch(items)
    }

    func didGetError(_ errr: Error) {
        object?.didGetError(errr)
    }
}
