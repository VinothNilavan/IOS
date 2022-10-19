
import UIKit

protocol ValidateOtpViewModelDelegate: AnyObject {
    func didReceiveValidateOtpResponse(_ response: ValidateOTPResponse)
    func didReceiveValidateOtpError(_ error: String)
}

class ValidateOtpViewModel {
    
  private var client: NetworkWrapper = NetworkWrapper(session: URLSession.shared)
    
  weak var delegate: ValidateOtpViewModelDelegate?

    func validateOTP(session: String, otp: String) {
        let request = ApiService.validateOTP(session, otp)
        client.request(request) { [weak self]  (response:ValidateOTPResponse) in
            self?.delegate?.didReceiveValidateOtpResponse(response)
        } onError: { [weak self] error in
            self?.delegate?.didReceiveValidateOtpError(error.localizedDescription)
        }
    }
    
    func addVisitor(name:String,mobile:String) {
        let req = ApiService.addVisitor(name, mobile)
        client.request(req) { (res:AddVisitedResponse) in
            print(#function,res)
        } onError: { (er) in
            print(er.localizedDescription)
        }
    }
}
