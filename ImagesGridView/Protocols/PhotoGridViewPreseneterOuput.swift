//
//  PhotoGridViewPreseneterOuput.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
protocol PhotoGridViewPreseneterOuput {
    func fetchDidComplete(withPictures: [Picture])
    func fetchFailure(withError: Error)
}
