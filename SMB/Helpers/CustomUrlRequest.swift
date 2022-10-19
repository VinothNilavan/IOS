//
//  CustomUrlRequest.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func create(method: HTTPMethod, params : [String : Any],  url: URL,headers:HTTPHeaders) -> URLRequest? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var request = components?.url.map({ URLRequest(url: $0) })
        request?.httpMethod = method.rawValue
        for header in headers {
            request?.addValue(header.value, forHTTPHeaderField: header.key)
        }
        print(request?.allHTTPHeaderFields ?? "")
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == .get {
            return request
        }
        do  {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            request?.httpBody = jsonData
            let d = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(d)
        }
        catch { }
        request?.cachePolicy = .reloadIgnoringCacheData
        return request
    }
}
