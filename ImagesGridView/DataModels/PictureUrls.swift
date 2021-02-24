//
//  Links.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
struct PictureUrls : Codable{
    let raw : URL
    let full : URL
    let regular : URL
    let small : URL
    let thumb : URL

    private enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
