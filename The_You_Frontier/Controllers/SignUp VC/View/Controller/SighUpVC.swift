//
//  SighUpVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/12/23.
//

import UIKit

class SighUpVC: UIViewController {
    
    //MARK: Properties
    var callApiService = HttpUtility()
    
    //MARK: Outlets
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var mobileNoView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var newPasswordView: UIView!
    
    @IBOutlet weak var nameTxt: MyTextField!
    
    @IBOutlet weak var emailTxt: MyTextField!
    
    @IBOutlet weak var mobNoTxt: MyTextField!
    
    @IBOutlet weak var newPasswordTxt: MyTextField!
    
    @IBOutlet weak var passwordTxt: MyTextField!
    
    @IBOutlet weak var signUpBtn: MyButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func checkValidation() {
        
        
        guard let name = nameTxt.text?.trim() , !name.isEmpty else {
            
            self.ShowAlert(message:"Please enter user name", title: "UserName")
            
            return
        }
        
        guard let email = emailTxt.text?.trim() , !email.isEmpty else {
            
            self.ShowAlert(message:"Please enter email Id", title: "Email")
            
            return
        }
        
        guard  email.isValidEmail() else {
            
            self.ShowAlert(message:"Please enter valid email Id", title: "Email")
            
            return
        }
        
        guard let phone = mobNoTxt.text?.trim() , !phone.isEmpty else {
            
            self.ShowAlert(message:"Please enter mobile number", title: "Mobile Number")
            
            return
        }
        
        guard phone.isLengthValid(minLength: 10, maxLength: 13) else  {
            self.ShowAlert(message: TYF_AlertText.mobileValidation, title: "Mobile Number")
            return
        }
        
        guard let password = passwordTxt.text?.trim() , !password.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messagePassword, title: TYF_AlertText.password)
            
            return
        }
        
        guard password.isLengthValid(minLength: 8, maxLength: 15) else  {
            self.ShowAlert(message: TYF_AlertText.passValidation, title: "Password")
            return
        }
        
        
        guard let confirmPass = newPasswordTxt.text?.trim() , !confirmPass.isEmpty else {
            
            self.ShowAlert(message:TYF_AlertText.messageconfirmPass, title: TYF_AlertText.confirmPass)
            
            return
        }
        
        //        guard confirmPass.isLengthValid(minLength: 8, maxLength: 15) else  {
        //            self.ShowAlert(message: TYF_AlertText.passConfirmValidation, title: " Confirm Password")
        //            return
        //        }
        
        if password == confirmPass {
            
            
            checkNetwork(params: SignInParams(name: name,email:email ,mobile: phone, password: confirmPass))
            
        }
        else {
            self.ShowAlert(message: TYF_AlertText.validPass1, title: TYF_AlertText.confirmPass)
        }
        
        
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:SignInParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: false, requestMethod:HttpMethod.post,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.signUpURL, response: SignInModel.self)
                    
                    dump(response)
                    if response.status == true {
                        // popViewController()
                        kUserDefaults.set(response.token, forKey: AppKeys.token)
                        kUserDefaults.set(response.data?.email, forKey: AppKeys.email)
                        kUserDefaults.set(response.data?.name, forKey: AppKeys.name)
                        kUserDefaults.set(response.data?.mobile, forKey: AppKeys.phone)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            self.switchToHomeScreen()
                        }
                        self.showToast(message: "Welcome \(response.data?.name ?? "")!  Signup in...", font: UIFont.systemFont(ofSize: 15))
                        
                        
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
    @IBAction func onClickSignUp(_ sender: Any) {
        
        checkValidation()
        
    }
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        popViewController()
        
    }
    
    
    
}
