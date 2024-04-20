//
//  LikePopUpScreen.swift
//  The_You_Frontier
//
//  Created by Chawtech on 18/01/24.
//

import UIKit

protocol EventDetailProtocol {
    func callApiService(setValue:Bool)
}

class LikePopUpScreen: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var popupView: UIView!
  
    @IBOutlet weak var yesBtn: UIButton!
    
    var callApiService = HttpUtility()
    var listId : Int!
    var eventDetailProtocol: EventDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.setViewBorderColor(color: UIColor.bgColor, width: 0.8, cornerRadius: 8)
        yesBtn.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        mainView.addGestureRecognizer(tap)
        
        mainView.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func getInTouchActionBtn(_ sender: MyButton) {
        checkNetwork ()
        
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    showActivityIndicator()
                    
                        let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.addIntrestURL + "\(listId!)" , response: EventDetailModel2.self)
                        
                        if response.status == true {
                            self.showToast(message: response.message ?? "", font: UIFont.systemFont(ofSize: 15))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.hideActivityIndicator()
                                self.eventDetailProtocol?.callApiService(setValue: true)
                                self.dismiss(animated: true)
                            }
                            
                        }
                        else{
                            self.hideActivityIndicator()
                            
                            self.ShowAlert(message: response.message ?? "")
                        }
                    
                }
                catch{
                    self.hideActivityIndicator()
                    self.ShowAlert(message: error.localizedDescription)
                    
                }
            }
            
        }
        else {
            self.ShowAlert(message:TYF_AlertText.internetConnection)
        }
    }
    
}
