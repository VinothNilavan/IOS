
import UIKit

let OTPDigits = 6

class ValidateOtpViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: TransitionButton!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var mobileTextFieldView: UITextField!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var timeLbl: UILabel!
    var isShareAccepted = 0
    var mobileNumber: String = ""
    var countryCode = ""
    var timer : Timer?
    var interface : SMBBaseInterface?
    var optString = ""
    var userType : Int = 0
    
    private var viewModel: ValidateOtpViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var loginViewModel: LoginViewModel! {
        didSet {
          loginViewModel.delegate = self
        }
      }
    
    class func controller(interface:SMBBaseInterface) -> ValidateOtpViewController {
        SMBFactory.getOTPValidateController(interface)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        mobileTextFieldView.delegate = self
    }
    func setupOtpView() {
        self.otpTextFieldView.fieldsCount        = OTPDigits
        self.otpTextFieldView.fieldBorderWidth   = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.black
        self.otpTextFieldView.filledBorderColor  = UIColor.custom.appGreen
        self.otpTextFieldView.cursorColor        = UIColor.black
        self.otpTextFieldView.displayType        = .underlinedBottom
        self.otpTextFieldView.fieldSize          = 40
        self.otpTextFieldView.separatorSpace     = 8
        self.otpTextFieldView.delegate           = self
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.initializeUI()
    }
  override func viewDidLoad() {
    setupOtpView()
    viewModel                   = ValidateOtpViewModel()
    loginViewModel              = LoginViewModel()
    mobileTextFieldView.text    = interface?.mobile?.applyPatternOnNumbers(pattern: "## ### ### ####", replacmentCharacter: "#")
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    
    resendBtn.isEnabled = false
    
    self.startTimer()
  }
    
    var timerCompleted = false
    var count = 60
    func startTimer () {
        self.timerCompleted = false
        self.timeLbl .text = "01:00"
        self.count = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.count -= 1
            if self.count == 0 {
                self.timer?.invalidate()
                self.timerCompleted      = true
                self.timeLbl.text        = nil
                self.resendBtn.isEnabled = true
                return
            }
            let tx =  self.count < 10 ? "00:0\(self.count)" : "00:\(self.count)"
            self.timeLbl.text = tx
        })
    }

    @objc func adjustForKeyboard(notification: Notification) {
      let userInfo = notification.userInfo!
      
      let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
      
      if notification.name == UIResponder.keyboardWillHideNotification {
        scrollView.contentInset = UIEdgeInsets.zero
      } else {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
      }
    }
      
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func validateOtp(_ sender: TransitionButton) {
        let phone = optString.trim
        guard phone.count == OTPDigits  else {
            showAlert(message: "Please Enter Valid OTP", title: "Warning")
            return
        }
        sender.startAnimation()
//        viewModel.validateOTP(session: interface?.session ?? "", otp:optString)

        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue       = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(3) // 3: Do your networking task or background work here.
            DispatchQueue.main.async {
                self.submitBtn.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                    var interface     = SMBBaseInterface()
                    interface.mobile  = self.mobileTextFieldView.text
                //        interface.name    = userName.text
                    let vc            = SMBFactory.getHomeController()
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
  
  @IBAction func resendOtp(_ sender: AnyObject) {
        guard self.timerCompleted else {
            return
        }
        resendBtn.isEnabled = false
        loginViewModel.fetchOTP(mobileNumber: mobileNumber)
    }
  
    @IBAction func sendBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ValidateOtpViewController: ValidateOtpViewModelDelegate {
  func didReceiveValidateOtpResponse(_ response: ValidateOTPResponse) {
    DispatchQueue.main.async {
        if response.Status?.lowercased() == SMBConstants.Api.success, response.Details?.lowercased() == SMBConstants.Api.otp_matched {
            SMBDefaults.loggedIn    = true
            SMBDefaults.userName    = self.interface?.name ?? ""
            SMBDefaults.phoneNumber = self.interface?.mobile ?? ""
            self.submitBtn.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                let vc            = SMBFactory.getHomeController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.viewModel.addVisitor(name: self.interface?.name ?? "" , mobile:self.interface?.mobile ?? "" )
        }
        else {
            self.submitBtn.stopAnimation()
            self.showAlert(message: "Please try gain", title: "Alert")
        }
    }
  }
  
  func didReceiveValidateOtpError(_ error: String) {
    DispatchQueue.main.async {
        self.submitBtn.stopAnimation()
        self.showAlert(message: error, title: "Error")
    }
  }
}

extension ValidateOtpViewController: LoginResultViewModelDelegate {
        
  func didReceiveOtpResponse(_ response: OTPResponse) {
    DispatchQueue.main.async {
        if response.Status?.lowercased() == SMBConstants.Api.success {
            self.interface?.session =  response.Details
            self.submitBtn.stopAnimation()
            self.startTimer()
        }
    }
  }
  
  func didReceiveOtpError(_ error: String) {
        DispatchQueue.main.async {
            self.submitBtn.stopAnimation()
            self.showAlert(message: error, title: "Error")
        }
    }
}
extension ValidateOtpViewController : OTPFieldViewDelegate {
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return false
    }
    
    func enteredOTP(otp: String) {
        print(otp)
        optString = otp
    }
}
extension ValidateOtpViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.navigationController?.popViewController(animated: true)
    }
}
                                    
