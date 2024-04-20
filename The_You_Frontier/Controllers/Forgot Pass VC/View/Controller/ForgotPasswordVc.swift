//
//  ForgotPasswordVc.swift
//  The_You_Frontier
//
//  Created by CTS on 26/12/23.
//

import UIKit

class ForgotPasswordVc: UIViewController {
    
    var callApiService = HttpUtility()
    var emailId = ""
    var isSelected = true
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var emailTxtView: UIView!
    
    
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.setHidesBackButton(false, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isSelected = true
    }
    
    @IBAction func onClickContinue(_ sender: Any) {
        
        if isSelected == true {
            checkValidation()
        }
        
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
        
        isSelected = false
        emailId = email
        checkNetwork(params: ForgotPassParams(email: email))
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:ForgotPassParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: false, requestMethod:HttpMethod.post,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.forgetUpURL, response: ForgotPassModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CodeVerificationVC") as! CodeVerificationVC
                        vc.emailId = emailId
                        self.pushToVC(vc, animated: true)
                        
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
