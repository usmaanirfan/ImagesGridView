//
//  User.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

struct User : Codable {
    let id : String
    let updatedAt : String?
    let username : String?
    let name : String
    let firstName : String?
    let lastName : String?
    let userLinks : UserLinks
    let totalLikes: Int
    let totalPhotos: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case updatedAt        = "updated_at"
        case username
        case name
        case firstName        = "first_name"
        case lastName         = "last_name"
        case userLinks        = "links"
        case totalLikes       = "total_likes"
        case totalPhotos      = "total_photos"
    }
}
