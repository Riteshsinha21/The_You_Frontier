//
//  EventVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import UIKit
import SideMenu

class EventVC: UIViewController {

    //MARK: Properties

    var menu: SideMenuNavigationController?
    var eventListData = [EventData]()
    var callApiService = HttpUtility()
    
    
    @IBOutlet weak var tableViewEventList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTableView()
    }
    
    func setUpTableView(){
        tableViewEventList.delegate = self
        tableViewEventList.dataSource = self
        tableViewEventList.register(UINib(nibName: "EventListTblCell", bundle: .main), forCellReuseIdentifier: "EventListTblCell")
        kUserDefaults.set("ProfileTab", forKey: AppKeys.tabName)
        
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.menuWidth = 300
        
        checkNetwork ()
        
    }


    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            
            Task{
                do{
                    showActivityIndicator()
                    
                    let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.eventListURL, response: EventModel.self)
                    
                    if response.status == true {
                        eventListData = response.data ?? []
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.hideActivityIndicator()
                            self.tableViewEventList.reloadData()
                        }
                        
                    }else{
                        hideActivityIndicator()
                        self.ShowAlert(message: response.message ?? "")
                    }
                }
                catch{
                    hideActivityIndicator()
                    self.ShowAlert(message: error.localizedDescription)
                }
            }
            
        }
        else {
            self.ShowAlert(message:TYF_AlertText.internetConnection)
        }
    }
    
    @IBAction func onClickSideMenuBtn(_ sender: UIButton) {
        present(menu!,animated: true, completion: nil )
    }
}
