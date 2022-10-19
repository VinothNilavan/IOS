//
//  ApiAdapter.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

protocol ApiType {
  /// The target's base `URL`.
  var baseURL: String { get }
  
  /// The path to be appended to `baseURL` to form the full `URL`.
  var path: URL { get }
  
  /// The HTTP method used in the request.
  var httpMethod: HTTPMethod { get }
  
  /// Params passed in request
  var parameters: [String: Any] { get }
  
  /// The headers to be used in the request.
  var headers: HTTPHeaders? { get }
}
