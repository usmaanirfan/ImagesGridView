//
//  WeakRef+GridViewPresenterOutput.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

extension WeakRef: PhotoGridViewPreseneterOuput where T: PhotoGridViewPreseneterOuput {
    func fetchDidComplete(withPictures: [Picture]) {
        object?.fetchDidComplete(withPictures: withPictures)
    }

    func fetchFailure(withError: Error) {
        object?.fetchFailure(withError: withError)
    }
}
