//
//  LoginViewModel.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

protocol LoginResultViewModelDelegate: AnyObject {
    func didReceiveOtpResponse(_ response: OTPResponse)
    func didReceiveOtpError(_ error: String)
}

class LoginViewModel {
    
    weak var delegate: ValidateOtpViewModelDelegate?
    weak var loginDelegate: LoginResultViewModelDelegate?
    private var client: NetworkWrapper = NetworkWrapper(session: URLSession.shared)

    func fetchOTP(mobileNumber:String) {
        
        let req     = ApiService.reqOTP(number: mobileNumber)
        client.request(req) { [weak self](res:OTPResponse) in
            print(res)
            self?.loginDelegate?.didReceiveOtpResponse(res)
        } onError: { [weak self] (er) in
            print(er)
            self?.loginDelegate?.didReceiveOtpError(er.localizedDescription)
        }
    }
}
