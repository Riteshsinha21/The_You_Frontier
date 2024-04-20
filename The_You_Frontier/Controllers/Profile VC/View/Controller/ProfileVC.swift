//
//  ProfileVC.swift
//  The_You_Frontier
//
//  Created by CTS on 03/01/24.
//

import UIKit
import SideMenu
import CoreLocation

class ProfileVC: UIViewController {
    
    //MARK: Properties
    
    var isTabHidden = false
    var callApiService = HttpUtility()
    
    //MARK: Outlets
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var doneBtn: MyButton!
    @IBOutlet weak var lblProfile: MyBoldLabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    
    
    
    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
    }
    
    func setupUI(){
        
        nameView.cornerRadius()
        phoneView.cornerRadius()
        emailView.cornerRadius()
        editProfile()
        kUserDefaults.set("ProfileTab", forKey: AppKeys.tabName)
        let name = kUserDefaults.value(forKey: AppKeys.name) as? String
        let email = kUserDefaults.value(forKey: AppKeys.email)!
        let phone = kUserDefaults.value(forKey: AppKeys.phone)!
        
        self.textName.text = name?.capitalized
        self.textEmail.text = email as? String
        self.textPhone.text = phone as? String
        
    }
    
    func editProfile(){
        
        if isTabHidden {
            
            doneBtn.isHidden = false
            lblProfile.text = " Edit Profile"
            btnEditProfile.isHidden = true
            textName.isUserInteractionEnabled = true
            textEmail.isUserInteractionEnabled = false
            textPhone.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.isHidden = true
            backBtn.setImage(UIImage(named: "back"), for: .normal)
            
        }else{
            
            doneBtn.isHidden = true
            lblProfile.text = "Profile"
            btnEditProfile.isHidden = false
            textName.isUserInteractionEnabled = false
            textEmail.isUserInteractionEnabled = false
            textPhone.isUserInteractionEnabled = false
            self.tabBarController?.tabBar.isHidden = false
            backBtn.setImage(UIImage(named: "menu"), for: .normal)
            
        }
        
    }
    
    @IBAction func onClickMenuBtn(_ sender: Any) {
        if isTabHidden {
            isTabHidden = false
            editProfile()
        }else{
            present(menu!,animated: true, completion: nil )
        }
    }
    
    @IBAction func editProfleActionBtn(_ sender: UIButton) {
        isTabHidden = true
        editProfile()
        
        
    }
    
    @IBAction func doneActionBtn(_ sender: MyButton) {
        
        checkValidation()
        //        isTabHidden = false
        //        editProfile()
        
    }
    
    
    func checkValidation() {
        
        guard let name = textName.text?.trim() , !name.isEmpty else {
            
            self.ShowAlert(message:"Please enter user name", title: "UserName")
            
            return
        }
        
        guard let phone = textPhone.text?.trim() , !phone.isEmpty else {
            
            self.ShowAlert(message:"Please enter mobile number", title: "Mobile Number")
            
            return
        }
        
        guard phone.isLengthValid(minLength: 10, maxLength: 13) else  {
            self.ShowAlert(message: TYF_AlertText.mobileValidation, title: "Mobile Number")
            return
        }
        
        checkNetwork(params: ProfileParams(name: name,mobile: phone))
        
    }
    //MARK:-  check internet Connection
    
    func checkNetwork (params:ProfileParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    
                    let response = try await callApiService.postOperation(sendHeader: true, requestMethod:HttpMethod.put,params:params, requestUrl: BaseUrl.baseURL + BaseUrl.updateProfileURL, response: ProfileModel.self)
                    
                    dump(response)
                    if response.status == true {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            kUserDefaults.set(response.data?.name, forKey: AppKeys.name)
                            kUserDefaults.set(response.data?.mobile, forKey: AppKeys.phone)
                            
                            self.isTabHidden = false
                            self.editProfile()
                        }
                        self.showToast(message: "Profile Updated Successfully !", font: UIFont.systemFont(ofSize: 15))
                        
                        
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
    
    
    func openGoogleMap() {
        var strLat1 = "28.628151"
        var strLong2 = "77.367783"
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(strLat1),\(strLong2)&directionsmode=driving")!)
        }
        else {
            print("Can't use comgooglemaps://");
            let myAddress = "One,Apple+Park+Way,Cupertino,CA,95014,USA"
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(myAddress) { (placemarks, error) in
                guard let placemarks = placemarks?.first else { return }
                let location = placemarks.location?.coordinate ?? CLLocationCoordinate2D()
                //   guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
                guard let url = URL(string:"http://maps.apple.com/?daddr=\(strLat1),\(strLong2)") else { return }
                UIApplication.shared.open(url)
            }
        }
    }
    
}
