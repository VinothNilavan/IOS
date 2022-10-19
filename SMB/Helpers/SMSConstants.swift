//
//  SMSConstants.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation
import UIKit

let admins = ["8553038203","8553038211","8610254854‬","8088780940"]

struct SMBConstants {
    struct Api {

        static let OTPKey     = "fa15a2ed-fe2a-11ea-9fa5-0200cd936042"
        static let baseUrl    = "http://nmrathinam.in/app/api/"
        static let OTPBaseUrl = "https://2factor.in/API/V1/" + OTPKey + "/SMS/"
        
        static func OTP(number:String) -> String {
            return "https://2factor.in/API/V1/" + OTPKey + "/SMS/" + number + "/AUTOGEN"
        }
        static func validateOTP(otp:String,session:String) -> String {
            return "https://2factor.in/API/V1/" + OTPKey + "/SMS/VERIFY/" + session + "/" + otp
        }
        static let success     = "success"
        static let otp_matched = "otp matched"
        
    }
    struct StoryBoard {
        static let Login        = "LoginViewController"
        static let Home         = "Main"
        static let OTPValidate  = "ValidateOtpViewController"
    }
    struct Controller {
        static let Login        = "login"
        static let Home         = "home"
        static let OTPValidate  = "validateOTP"
        static let details      = "detail"
    }
}

struct Helper {
    static func getController(storyBoard:String,controllerId:String) -> UIViewController {
        let homeSt     = UIStoryboard.init(name: storyBoard, bundle:nil)
        let controller = homeSt.instantiateViewController(withIdentifier: controllerId)
        return controller
    }
}

var vSpinner : UIView?

extension UIViewController {
    static func instance<T>(type: T.Type) -> T where T: UIViewController {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! T
    }
    
    static func instance<T: UIViewController>() -> T {
        let name       = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! T
        return controller
    }
    
    static func instanceController<T: UIViewController>(id:String) -> T? {
        let name       = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc         = storyboard.instantiateViewController(withIdentifier: id)
        return vc as? T
    }
    
      func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
          spinnerView.addSubview(ai)
          onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
      }
  
      func removeSpinner() {
        DispatchQueue.main.async {
          vSpinner?.removeFromSuperview()
          vSpinner = nil
        }
    }
  
    func showAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action          = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
