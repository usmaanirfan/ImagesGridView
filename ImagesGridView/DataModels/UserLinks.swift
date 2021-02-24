//
//  UserLinks.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

struct UserLinks : Codable{
    let own : URL
    let html : URL
    let photos : URL
    let portfolio : URL

    private enum CodingKeys: String, CodingKey {
        case own              = "self"
        case html
        case photos
        case portfolio
    }
}
