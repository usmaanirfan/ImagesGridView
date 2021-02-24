//
//  PictureLinks.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
struct PictureLinks : Codable{
    let own : URL
    let html : URL
    let download : URL
    let downloadLocation : URL

    private enum CodingKeys: String, CodingKey {
        case own              = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}
