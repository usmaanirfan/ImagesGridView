//
//  URLSessionMock.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

@testable import ImagesGridView

class URLSessionMock: URLSessionProtocol {
    func dataTask(with reuest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var filePath : String?
        if reuest.url?.absoluteString.contains("search") == true {
            if let path = Bundle.main.path(forResource: "SearchDetailData", ofType: "json") {
                filePath = path
            }
        } else {
            if let path = Bundle.main.path(forResource: "PhotoDetailData", ofType: "json") {
                filePath = path
            }
        }
        if let path = filePath {
            do {
                let response = HTTPURLResponse(url: reuest.url!, statusCode: 200,
                                               httpVersion: nil, headerFields: nil)!
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                defer { completionHandler(data, response, nil) }
            } catch {
                // handle error
            }
        }
        return URLSessionDataTaskMock()
    }

}
