//
//  LogOutPopUpVC.swift
//  The_You_Frontier
//
//  Created by CTS on 18/01/24.
//

import UIKit

class LogOutPopUpVC: UIViewController {
    
    var callApiService = HttpUtility()
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var popupView: UIView!
    
    
    @IBOutlet weak var cancleBtn: UIButton!
    
    
    @IBOutlet weak var yesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.setViewBorderColor(color: UIColor.bgColor, width: 0.8, cornerRadius: 8)
        cancleBtn.layer.cornerRadius = 5
        yesBtn.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        mainView.addGestureRecognizer(tap)
        
        mainView.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func onClickCancle(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    
                    let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.logoutURL, response: ForgotPassModel.self)
                    
                    if response.status == true {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            self.switchToLoginVc()
                        }
                        self.showToast(message: response.message ?? "" , font: UIFont.systemFont(ofSize: 15))
                        
                        
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
    
    @IBAction func onClickYesBtn(_ sender: UIButton) {
        
        checkNetwork()
        
        
    }
    
    func switchToLoginVc() {
        kUserDefaults.set("Invalid", forKey: AppKeys.token)
        kUserDefaults.removeObject(forKey: AppKeys.email)
        // /*
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let nc = UINavigationController.init(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        nc.setNavigationBarHidden(false, animated: false)
        //        let nc = SwipeableNavigationController(rootViewController: vc)
        //        nc.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            
            UIApplication.shared.windows.first?.rootViewController = nc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            let bounds = UIScreen.main.bounds
            TYF_AppDelegate.window = UIWindow(frame: bounds)
            TYF_AppDelegate.window?.rootViewController = nc
            TYF_AppDelegate.window?.makeKeyAndVisible()
        }
        
    }
 
}
