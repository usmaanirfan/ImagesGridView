//
//  NetworkRequestInterface.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
protocol NetworkRequestInterface {
    typealias APIManagerResult<T> = (Result<T, Error>) -> Void
    var session: URLSessionProtocol { get set }
    init(session: URLSessionProtocol)
    func fetchPhotoDetails<T: Decodable>(dataType: T.Type, requestType : RequestType,with parameters : [String: Any]?, completionHandler: @escaping APIManagerResult<T>)
}
