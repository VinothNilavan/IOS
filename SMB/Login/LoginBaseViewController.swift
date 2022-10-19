//
//  LoginBaseViewController.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit

class LoginBaseViewController: UIViewController, LoginResultViewModelDelegate {
            
    @IBOutlet weak var logoImageView: UIImageView!
    private var loginViewModel: LoginViewModel! {
        didSet {
            loginViewModel.loginDelegate = self
        }
      }

    @IBOutlet weak var sendOTPBtn: TransitionButton!
    @IBOutlet weak var phoneNumber: RoundTextField!
    @IBOutlet weak var userName: RoundTextField!
    @IBOutlet weak var processLbl: UILabel!
    
    @IBAction func sendOtpAction(_ sender: TransitionButton) {
        phoneNumber.resignFirstResponder()
        let uName = (userName.text ?? "") .trim
        let phone = (phoneNumber.text ?? "") .trim
        guard uName.count > 3  else {
            showAlert(message: "Please Enter Name", title: "Alert")
            return
        }
        guard phone.count == 10  else {
            showAlert(message: "Please Enter Phone number", title: "Alert")
            return
        }
        sender.startAnimation()
//        loginViewModel.fetchOTP(mobileNumber: phone)
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue       = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(1) // 3: Do your networking task or background work here.
            DispatchQueue.main.async {
                sender.stopAnimation()
                var interface      = SMBBaseInterface()
                interface.mobile   = self.phoneNumber.text
                interface.name     = self.userName.text
                let vc             = SMBFactory.getOTPValidateController(interface)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    private func initialise() {
        let bottomLine              = CALayer()
        bottomLine.frame            = CGRect(x: 0.0, y: userName.frame.height + 10, width: userName.frame.width , height: 1.0)
        bottomLine.backgroundColor  = UIColor.gray.cgColor
        userName.borderStyle        = UITextField.BorderStyle.none
        userName.layer.addSublayer(bottomLine)
        loginViewModel = LoginViewModel()
    }
    override func viewDidLoad() {
        initialise()
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginBaseViewController {
    func didReceiveOtpResponse(_ response: OTPResponse) {
        sendOTPBtn.stopAnimation()
        if response.Status?.lowercased() == SMBConstants.Api.success {
            var interface      = SMBBaseInterface()
            interface.mobile   = self.phoneNumber.text
            interface.name     = self.userName.text
            interface.session  = response.Details
            let vc             = SMBFactory.getOTPValidateController(interface)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            showAlert(message: "Please try again", title: "Alert")
        }
    }
    
    func didReceiveOtpError(_ error: String) {
        sendOTPBtn.stopAnimation()
        showAlert(message:error.localizedCapitalized, title: "Alert")
    }
}
