//
//  NetworkExecutor.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

enum HttpClientError: Error {
    case unknown
    case nonHTTPResponse(response: URLResponse)
}

class NetworkExecutor {
            
    private let session : URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func execute(request: URLRequest, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        if let body = request.httpBody {
            let d = try? JSONSerialization.jsonObject(with: body, options: .allowFragments)
            print(d ?? "")
        }
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response, let data = data else {
                completionHandler(nil, nil, HttpClientError.unknown)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(data, nil, HttpClientError.nonHTTPResponse(response: response))
                return
            }
            completionHandler(data, httpResponse, error)
        }).resume()
    }
}
