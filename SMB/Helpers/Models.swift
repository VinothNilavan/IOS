//
//  Models.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

protocol SMBModelProtocol : Codable {
    var name:String? { get }
    var id:String? { get }
}
struct Product : SMBModelProtocol {
    var name: String?
    var id,imageUrl,desc:String?
    enum CodingKeys: String, CodingKey {
        case name,id
        case imageUrl = "image_url"
        case desc     = "description"
    }
}
struct User : SMBModelProtocol {
    var name: String?
    var id: String?
}
struct ValidateOTPResponse: Codable {
    let isExistingUser: Bool?
    var Details,Status: String?
    let user : User?
    let responseCode : Int?
}
struct OTPResponse: Codable {
    let otp,Status: String?
    var message: String?
    var Details:String?
    let responseCode : Int?
}
struct VisitedUser:SMBModelProtocol {
    var name: String?
    var mobile_number:String?
    var created:String?
    var visited_time:String?
    var id: String?
    var error :String?

}
struct AddVisitedResponse :Codable {
    var status : String?
}
