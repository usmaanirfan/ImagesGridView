//
//  GridViewPreseneterInterface.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
protocol GridViewPreseneterInterface {
    var photos : [Picture] { get set }
    var searchedPhotos : [Picture] { get set }
    func reloadData()
    init(photoGridViewPreseneterOuput: PhotoGridViewPreseneterOuput)
    func searchItem(text : String, isStart : Bool)
    func dismissSearchController()
}
