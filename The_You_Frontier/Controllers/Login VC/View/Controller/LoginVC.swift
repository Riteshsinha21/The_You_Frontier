//
//  LoginVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/12/23.
//

import UIKit


class LoginVC: UIViewController {
    
    //MARK: Property
    
    var isSecure = false
    var callApiService = HttpUtility()
    
    //MARK: Outlets
    
    @IBOutlet weak var btnCloseEye: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxt: MyTextField!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passTxt: MyTextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSecure = true
        passTxt.isSecureTextEntry = true
        btnCloseEye.setImage(UIImage(named: "closeEye"), for: .normal)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        emailTxt.text = ""
        passTxt.text = ""
        emailTxt.resignFirstResponder()
        passTxt.resignFirstResponder()
    }
    
    func checkValidation() {
        
        guard let email = emailTxt.text?.trim() , !email.isEmpty else {
            
            self.ShowAlert(message:"Please enter email Id", title: "Email")
            
            return
        }
        
        guard  email.isValidEmail() else {
            
            self.ShowAlert(message:"Please enter valid email Id", title: "Email")
            
            return
        }
        
        guard let password = passTxt.text?.trim() , !password.isEmpty else {
            
            self.ShowAlert(message:"Please enter password", title: "Password")
            
            return
        }
        
        
        //checkNetwork(params: LoginParams(email: "frontier@yopmail.com",password: "1234567",device_token: "5656565wtwrwf"))
        
        checkNetwork(params: LoginParams(email: email,password: password,device_token: deviceID))
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:LoginParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: false, requestMethod:HttpMethod.post,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.loginURL, response: LoginModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        kUserDefaults.set(response.token, forKey: AppKeys.token)
                        kUserDefaults.set(response.data?.email, forKey: AppKeys.email)
                        kUserDefaults.set(response.data?.name, forKey: AppKeys.name)
                        kUserDefaults.set(response.data?.mobile, forKey: AppKeys.phone)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            self.switchToHomeScreen()
                        }
                        self.showToast(message: "Welcome \(response.data?.name ?? "")!  Logging in...", font: UIFont.systemFont(ofSize: 15))
                        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        //                            switchToHomeScreen()
                        //                        }
                        
                        
                        
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
    
    func switchToHomeScreen(){
        let vc = TabBarVC.instantiate(fromAppStoryboard: .map)
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            TYF_AppDelegate.window?.rootViewController = vc
        }
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        checkValidation()
        // switchToHomeScreen()
        
    }
    
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SighUpVC") as! SighUpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickForgotPass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVc") as! ForgotPasswordVc
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func securePasswordAction(_ sender: UIButton) {
        
        if isSecure{
            isSecure = false
            passTxt.isSecureTextEntry = false
            btnCloseEye.setImage(UIImage(named: "openEye"), for: .normal)
        }else{
            isSecure = true
            passTxt.isSecureTextEntry = true
            btnCloseEye.setImage(UIImage(named: "closeEye"), for: .normal)
        }
    }
    
    
}
