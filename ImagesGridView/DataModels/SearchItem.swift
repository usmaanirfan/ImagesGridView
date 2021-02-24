//
//  SerachItem.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 22/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
struct SeacrhItem : Codable {
    let results : [Picture]

    private enum CodingKeys: String, CodingKey {
        case results
    }
}
