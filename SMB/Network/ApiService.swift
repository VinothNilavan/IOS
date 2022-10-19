//
//  ApiService.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get   = "GET"
    case post  = "POST"
}
public enum MultipartFormDataEncodingError: Error {
    case characterSetName
    case name(String)
    case value(String, name: String)
}

public enum NetworkClientError: Error {
    case unknown
    case httpRequestFailed(response: HTTPURLResponse, data: Data)
    case deserializationFailed(data: Data)
}
enum ApiService {
    case reqOTP(number:String)
    case validateOTP(_ session:String,_ otp:String)
    case getProducts(_ str:String)
    case visitedList(_ number:String)
    case addVisitor(_ name:String, _ phoneNumber:String)
}

extension ApiService: ApiType {
    var baseURL: String {
        switch self  {
        case .reqOTP,.validateOTP:
           return SMBConstants.Api.OTPBaseUrl
        default:
            return SMBConstants.Api.baseUrl
        }
    }
}

extension ApiService {
    var path: URL {
        var path1: String?
        switch self {
        case .reqOTP(let number):
            path1  = "+91" + number + "/AUTOGEN"
        case .getProducts:
            path1  = "dashboard.php"
        case .validateOTP(let session,let otp):
            path1  = "VERIFY/" + session + "/" + otp
        case .visitedList(let number):
            path1  = "members.php?admin=true&admin_number=" + number
        case .addVisitor(let name , let phone):
            path1  = "members.php?add_visitor=true&user_name=" + name + "&mobile_number=" + phone
        }
        path1 = ( path1?.replacingOccurrences(of: " ", with: "") ) ?? ""
        return URL(string: baseURL + (path1 ?? "") )!
    }
}
extension ApiService {
    var parameters: [String : Any] {
        switch self {
        case .reqOTP,.getProducts,.validateOTP,.visitedList,.addVisitor:
            return [:]
        }
    }
}
extension ApiService {
    var httpMethod: HTTPMethod {
        switch self {
        case .reqOTP,.getProducts,.addVisitor:
            return .get
        case .validateOTP,.visitedList:
            return .get
        }
    }
}
extension ApiService {
    var headers: HTTPHeaders? {
        switch self {
        case .getProducts, .validateOTP, .visitedList, .reqOTP, .addVisitor:
            return [:]
        }
    }
}
