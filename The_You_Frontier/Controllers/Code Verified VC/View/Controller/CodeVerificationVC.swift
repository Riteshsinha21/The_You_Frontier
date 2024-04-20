//
//  CodeVerificationVC.swift
//  The_You_Frontier
//
//  Created by CTS on 26/12/23.
//

import UIKit
import SGCodeTextField

class CodeVerificationVC: UIViewController {
    
    var emailId = ""
    var timer: Timer?
    var runCount = 30
    var callApiService = HttpUtility()
    
    @IBOutlet weak var lblShowTimer: MyRegularLabel!
    @IBOutlet weak var otpTextField: SGCodeTextField!
    
    @IBOutlet weak var VerifyNDProceedBtn: UIButton!
    
    @IBOutlet weak var btnResend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTimer()
    }
    
    
    //MARK:- Set Timer
    
    func setTimer(){
        btnResend.isHidden = true
        lblShowTimer.isHidden = false
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func fireTimer() {
        
        runCount -= 1
        btnResend.isHidden = true
        btnResend.isUserInteractionEnabled = false
        
        
        lblShowTimer.text = "Resend code \(runCount) sec"
        
        if runCount == 0 {
            
            btnResend.isUserInteractionEnabled = true
            btnResend.isHidden = false
            lblShowTimer.isHidden = false
            lblShowTimer.text = "Resend code"
            runCount = 30
            timer?.invalidate()
        }
        
    }
    @IBAction func onClickVerifyNdProceed(_ sender: Any) {
        checkValidation()
    }
    
    
    func checkValidation() {
        if otpTextField.text?.count ?? 0 < 6 {
            self.ShowAlert(message: "Please Enter OTP")
        }else {
            if otpTextField.text != "123456"{
                self.ShowAlert(message: "please Enter valid OTP 123456")
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                vc.otp = otpTextField.text!
                vc.email = emailId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    
    
    @IBAction func onClickResendAgain(_ sender: Any) {
        setTimer()
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: false, requestMethod:HttpMethod.post,params:ForgotPassParams(email: emailId), requestUrl: BaseUrl.baseURL + BaseUrl.forgetUpURL, response: ForgotPassModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        
                    }else{
                        self.ShowAlert(message: response.message ?? "")
                    }
                }
                catch{
                    
                    self.ShowAlert(message: error.localizedDescription)
                }
            }
            
        }
        else {
            self.ShowAlert(message:TYF_AlertText.internetConnection)
        }
        
        
    }
    
}
