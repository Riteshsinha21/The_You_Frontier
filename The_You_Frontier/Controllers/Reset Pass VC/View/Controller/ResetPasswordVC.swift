//
//  ResetPasswordVC.swift
//  The_You_Frontier
//
//  Created by CTS on 26/12/23.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    var callApiService = HttpUtility()
    var email = ""
    var otp = ""
    var isSecureNew = false
    var isSecureConfirm = false
    
    @IBOutlet weak var newPassView: UIView!
    
    @IBOutlet weak var eyeBtnNewPass: UIButton!
    @IBOutlet weak var eyeBtnConfirmPAss: UIButton!
    @IBOutlet weak var newPassTxt: UITextField!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBOutlet weak var confirmPassView: UIView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSecureNew = true
        isSecureConfirm = true
        newPassTxt.isSecureTextEntry = true
        confirmPassTxt.isSecureTextEntry = true
        eyeBtnNewPass.setImage(UIImage(named: "closeEye"), for: .normal)
        eyeBtnConfirmPAss.setImage(UIImage(named: "closeEye"), for: .normal)
        
    }
    
    
    func checkValidation() {
        
        guard let newPassword = newPassTxt.text?.trim() , !newPassword.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messagePassword, title: TYF_AlertText.password)
            
            return
        }
        
        guard newPassword.isLengthValid(minLength: 8, maxLength: 15) else  {
            self.ShowAlert(message: TYF_AlertText.passValidation, title: "Password")
            return
        }
        
        
        guard let confirmPass = confirmPassTxt.text?.trim() , !confirmPass.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messageconfirmPass, title: TYF_AlertText.password)
            
            return
        }
        
        //        guard confirmPass.isLengthValid(minLength: 8, maxLength: 15) else  {
        //            self.ShowAlert(message: TYF_AlertText.passValidation, title: "Password")
        //            return
        //        }
        
        if newPassword == confirmPass {
            
            
            checkNetwork(params: ResetPassParams(email:email, password: confirmPass ,otp: otp))
            
        }
        else {
            self.ShowAlert(message: TYF_AlertText.validPass, title: TYF_AlertText.passwordNotMatch)
        }
        
        
    }
    //MARK:-  check internet Connection
    
    func checkNetwork (params:ResetPassParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: false, requestMethod:HttpMethod.post,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.resetPassURL, response: ForgotPassModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        self.showToast(message: "Password reset Successfully!", font: UIFont.systemFont(ofSize: 15))
                        
                        
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
    
    @IBAction func confirmActionBtn(_ sender: MyButton) {
        checkValidation()
    }
    
    
    @IBAction func eyeBtnNewAction(_ sender: UIButton) {
        
        if isSecureNew{
            isSecureNew = false
            newPassTxt.isSecureTextEntry = false
            eyeBtnNewPass.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecureNew = true
            newPassTxt.isSecureTextEntry = true
            eyeBtnNewPass.setImage(UIImage(named: "closeEye"), for: .normal)
        }
        
    }
    
    
    @IBAction func eyeBtnConfrimAction(_ sender: UIButton) {
        
        if isSecureConfirm{
            isSecureConfirm = false
            confirmPassTxt.isSecureTextEntry = false
            eyeBtnConfirmPAss.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecureConfirm = true
            confirmPassTxt.isSecureTextEntry = true
            eyeBtnConfirmPAss.setImage(UIImage(named: "closeEye"), for: .normal)
        }
        
    }
    
    
    
}
