//
//  NetworkRequest.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

class NetworkRequest : NetworkRequestInterface{

    typealias APIManagerResult<T> = (Result<T, Error>) -> Void
    var session: URLSessionProtocol
    private var task: URLSessionDataTask?
    private var timeoutInterval = 20.0
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    var requestType : RequestType?

    required init(session: URLSessionProtocol) {
        self.session = session
    }

    func fetchPhotoDetails<T:Decodable> (dataType: T.Type, requestType : RequestType, with parameters : [String: Any]?, completionHandler: @escaping APIManagerResult<T>) {
        self.requestType = requestType
        guard let request = try? prepareURLRequest(with: self.requestType ?? .fetchPhotos, parameters: parameters) else {
            let error = RequestError.invalidURL
            completionHandler(.failure(error))
            return
        }
        self.task = self.session.dataTask(with: request) { data, response, error in
            self.processResponse(response, data: data, error: error) { result in
                switch result {
                 case .success(let data):
                    do {
                        let decodedJSON: T = try JSONDecoder().decode(T.self, from: data)
                            completionHandler(.success(decodedJSON))
                    } catch {
                            completionHandler(.failure(error))
                    }
                 case .failure(let error):
                        completionHandler(.failure(error))
                }
            }
        }
        self.task?.resume()
    }

    private func processResponse(_ response: URLResponse?, data: Data?, error: Error?, completionHandler: (Result<Data, Error>) -> Void) {
        if let error = error {
            completionHandler(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completionHandler(.failure(RequestError.noHTTPResponse))
            return
        }

        processHTTPResponse(httpResponse, data: data) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    final func processHTTPResponse(_ response: HTTPURLResponse, data: Data?, completionHandler: (Result<Data, Error>) -> Void) {
        let statusCode = response.statusCode

        if successCodes.contains(statusCode) {
            completionHandler(.success(data!))
        } else if failureCodes.contains(statusCode) {
            completionHandler(.failure(RequestError.http(status: statusCode)))
        } else {
            // Server returned response with status code different than expected `successCodes`.
            let info = [
                NSLocalizedDescriptionKey: "Request failed with code \(statusCode)",
                NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
            ]
            let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
            completionHandler(.failure(error))
        }
    }

    private func prepareURLRequest(with requestType : RequestType, parameters : [String: Any]?) throws -> URLRequest {

        guard let url = prepareURLComponents(requestType : requestType)?.url else {
            throw RequestError.invalidURL
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.query = queryParameters(parameters)
        var urlRequest = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        urlRequest.allHTTPHeaderFields = prepareHeaders()
        urlRequest.httpMethod = Method.get.rawValue
        return urlRequest
    }

    private func prepareURLComponents(requestType : RequestType)-> URLComponents? {
        guard let apiURL = URL(string: ConfigurationDetail.apiURL) else {
            return nil
        }
        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        switch requestType {
        case .searchPhotos:
            urlComponents?.path = ConfigurationDetail.searchPhotosEndPoint
        case .fetchPhotos:
            urlComponents?.path = ConfigurationDetail.getPhotosEndPoint
        default:
            return nil
        }
        return urlComponents
    }

    private func queryParameters(_ parameters: [String: Any]?, urlEncoded: Bool = false) -> String {
        var allowedCharacterSet = CharacterSet.alphanumerics
        allowedCharacterSet.insert(charactersIn: ".-_")

        var query = ""
        parameters?.forEach { key, value in
            let encodedValue: String
            if let value = value as? String {
                encodedValue = urlEncoded ? value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? "" : value
            } else {
                encodedValue = "\(value)"
            }
            query = "\(query)\(key)=\(encodedValue)&"
        }
        return query
    }

    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(ConfigurationDetail.accessKey)"
        return headers
    }
}
