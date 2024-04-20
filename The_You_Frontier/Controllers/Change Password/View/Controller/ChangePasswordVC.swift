//
//  ChangePasswordVC.swift
//  The_You_Frontier
//
//  Created by CTS on 03/01/24.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: Property
    
    var isSecureOldPass = false
    var isSecureNewPass = false
    var isSecureConfirmPass = false
    var callApiService = HttpUtility()
    
    @IBOutlet weak var eyeOldPassBtn: UIButton!
    @IBOutlet weak var eyeNewPassBtn: UIButton!
    @IBOutlet weak var eyeConfirmPassBtn: UIButton!
    @IBOutlet weak var txtOldPassword: MyTextField!
    @IBOutlet weak var txtNewPassword: MyTextField!
    @IBOutlet weak var txtConfirmPassword: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSecureOldPass = true
        isSecureNewPass = true
        isSecureConfirmPass = true
        txtOldPassword.isSecureTextEntry = true
        txtNewPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        eyeOldPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        eyeNewPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        eyeConfirmPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        
        
    }
    
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func eyeConfirmPassBtn(_ sender: UIButton) {
        
        if isSecureConfirmPass{
            isSecureConfirmPass = false
            txtConfirmPassword.isSecureTextEntry = false
            eyeConfirmPassBtn.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecureConfirmPass = true
            txtConfirmPassword.isSecureTextEntry = true
            eyeConfirmPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        }
    }
    
    @IBAction func eyeOldPassBtn(_ sender: UIButton) {
        
        if isSecureOldPass{
            isSecureOldPass = false
            txtOldPassword.isSecureTextEntry = false
            eyeOldPassBtn.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecureOldPass = true
            txtOldPassword.isSecureTextEntry = true
            eyeOldPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        }
    }
    
    @IBAction func eyeNewPassBtn(_ sender: UIButton) {
        
        if isSecureNewPass{
            isSecureNewPass = false
            txtNewPassword.isSecureTextEntry = false
            eyeNewPassBtn.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecureNewPass = true
            txtNewPassword.isSecureTextEntry = true
            eyeNewPassBtn.setImage(UIImage(named: "closeEye"), for: .normal)
        }
    }
    
    
    
    func checkValidation() {
        
        
        guard let oldPassword = txtOldPassword.text?.trim() , !oldPassword.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messageOldPassword, title: TYF_AlertText.oldPassword)
            
            return
        }
        
        //        guard oldPassword.isLengthValid(minLength: 8, maxLength: 15) else  {
        //            self.ShowAlert(message: TYF_AlertText.passValidation, title: "Old Password")
        //            return
        //        }
        //
        
        guard let newPass = txtNewPassword.text?.trim() , !newPass.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messageNewPass, title: TYF_AlertText.newPassword)
            
            return
        }
        
        guard newPass.isLengthValid(minLength: 8, maxLength: 15) else  {
            self.ShowAlert(message: TYF_AlertText.passConfirmValidation, title: " New Password")
            return
        }
        
        guard let confirmPass = txtConfirmPassword.text?.trim() , !confirmPass.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messageconfirmPass, title: TYF_AlertText.confirmPass)
            
            return
        }
        
        //        guard confirmPass.isLengthValid(minLength: 8, maxLength: 15) else  {
        //            self.ShowAlert(message: TYF_AlertText.passConfirmValidation, title: " Confirm Password")
        //            return
        //        }
        
        if newPass == confirmPass {
            
            
            checkNetwork(params:ChangePassParams(current_password: oldPassword, new_password: confirmPass))
            
        }
        else {
            self.ShowAlert(message: TYF_AlertText.validPass12, title: TYF_AlertText.confirmPass)
        }
        
        
    }
    //MARK:-  check internet Connection
    
    func checkNetwork (params:ChangePassParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: true, requestMethod:HttpMethod.post,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.changePasswordURL, response: ChangePassModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.popViewController()
                        }
                        self.showToast(message:response.message ?? "", font: UIFont.systemFont(ofSize: 15))
                        
                        
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
    
    @IBAction func doneActionBtn(_ sender: MyButton) {
        checkValidation()
    }
    
    
}
