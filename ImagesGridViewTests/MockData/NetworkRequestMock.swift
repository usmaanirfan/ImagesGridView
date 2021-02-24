//
//  NetworkRequestMock.swift
//  ImagesGridViewTests
//
//  Created by Usman Ansari on 23/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

//import UIKit
//@testable import ImagesGridView
//class NetworkRequestMock: NetworkRequestInterface {
//    typealias APIClientResult<T> = (Result<T, Error>) -> Void
//    var session: URLSessionProtocol
//    func fetchPhotoDetails<T>(dataType: T.Type, requestType: RequestType, with parameters: [String : Any]?, completionHandler: @escaping APIManagerResult<T>) where T : Decodable {
//        session.dataTask(with: url) { data, _, _ in
//            guard let jsonData = data else { return }
//
//            do {
//                let weatherResponse: T = try JSONDecoder().decode(T.self, from: jsonData)
//                completionHandler(.success(weatherResponse))
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//
//    required init(session: URLSessionProtocol) {
//        self.session = session
//    }

//    typealias APIClientResult<T> = (Result<T, Error>) -> Void
//    var session: URLSessionProtocol
//
//    required init(session: URLSessionProtocol) {
//        self.session = session
//    }
//
//    func fetch<T: Decodable>(dataType: T.Type, from url: URL, completionHandler: @escaping APIClientResult<T>) {
//        session.dataTask(with: url) { data, _, _ in
//            guard let jsonData = data else { return }
//
//            do {
//                let weatherResponse: T = try JSONDecoder().decode(T.self, from: jsonData)
//                completionHandler(.success(weatherResponse))
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//
//    func fetchAssetsData(from url: URL, completionHandler: @escaping DataResult) {
//        if let image = UIImage(named: "ic_error_info.png") {
//            if let data = image.pngData() {
//                completionHandler(.success(data))
//            }
//        }
//    }
//}
