//
//  SMBFactory.swift
//  SMB
//
//  Created by Vinoth on 24/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation
struct SMBBaseInterface {
    var mobile : String?
    var name : String?
    var session:String?
}
struct SMBFactory {
    static func getOTPValidateController(_ interface:SMBBaseInterface) -> ValidateOtpViewController {
        let stName      = SMBConstants.StoryBoard.OTPValidate
        let controller  = SMBConstants.Controller.OTPValidate
        let viewCon     = Helper.getController(storyBoard: stName, controllerId: controller)
        (viewCon as? ValidateOtpViewController)?.interface = interface
        return viewCon as! ValidateOtpViewController
    }
    
    static func getHomeController() -> HomeViewController {
        let stName      = SMBConstants.StoryBoard.Home
        let controller  = SMBConstants.Controller.Home
        let viewCon     = Helper.getController(storyBoard: stName, controllerId: controller)
        return viewCon as! HomeViewController
    }
    
    static func getDetail() -> DetailsViewController {
        let stName      = SMBConstants.StoryBoard.Home
        let controller  = SMBConstants.Controller.details
        let viewCon     = Helper.getController(storyBoard: stName, controllerId: controller)
        return viewCon as! DetailsViewController
    }
}
