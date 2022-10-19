//
//  NetWorkWrapper.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

class NetworkWrapper {
    
  private var networkExecutor: NetworkExecutor
  
  private let queue = DispatchQueue.main

    public init(session: URLSession = URLSession.shared) {
        self.networkExecutor = NetworkExecutor(session: session)
    }
    public func request<T: Codable> (_ request_: ApiType, didSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        let request = URLRequest.create(method: request_.httpMethod,params: request_
            .parameters, url: request_.path,headers: request_.headers!)!
        print(request.url ?? "")
        networkExecutor.execute(
            request: request,
            completionHandler: { (data, response, error) in
                switch self.getResponse(data: data, response: response, error: error) {
                case let .left(error):
                    self.queue.async {onError(error)}
                case let .right((_,data)):
                    let decoder = JSONDecoder.init()
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        print(jsonData)

                        let values  = try decoder.decode(T.self, from: data)
                        self.queue.async { didSuccess(values) }
                    }
                    catch let er {
                        print(er)
                        self.queue.async {onError(er)}
                    }
                }
        });
    }
    
  private func getResponse(data: Data?, response: HTTPURLResponse?, error: Error?) -> Either<Error, (HTTPURLResponse, Data)> {
    if let error = error {
      return .left(error)
    } else if let response = response, let data = data {
      return 200..<300 ~= response.statusCode ?
        .right((response, data)) :
        .left(NetworkClientError.httpRequestFailed(response: response, data: data))
    } else {
      return .left(NetworkClientError.unknown)
    }
  }
}
enum Either<L, R> {
    case left(L)
    case right(R)
}

func + <K,V> (left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
    guard let right = right else { return left }
    return left.reduce(right) {
        var new = $0 as [K:V]
        new.updateValue($1.1, forKey: $1.0)
        return new
    }
}
