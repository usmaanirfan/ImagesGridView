//
//  NetworkRequestProtocol.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

protocol NetworkRequestProtocol {
    typealias APIManagerResult<T> = (Result<T, Error>) -> Void
    var session: URLSessionProtocol { get set }
    init(session: URLSessionProtocol)
    func fetch<T: Decodable>(dataType: T.Type, from url: URL, completionHandler: @escaping APIManagerResult<T>)
}
