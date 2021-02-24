//
//  Picture.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
struct Picture : Codable{
    let id : String
    let width : Int
    let height : Int
    let color : String?
    let pictureUrls : PictureUrls
    let pictureLinks : PictureLinks
    let user : User

    private enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case pictureUrls         = "urls"
        case pictureLinks        = "links"
        case user
    }
}

extension Picture: Equatable {
    public static func == (lhs: Picture, rhs: Picture) -> Bool {
        return lhs.id == rhs.id
    }
}
