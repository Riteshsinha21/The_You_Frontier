//
//  NewsVC.swift
//  The_You_Frontier
//
//  Created by CTS on 03/01/24.
//

import UIKit
import SideMenu

class NewsVC: UIViewController {
    var menu: SideMenuNavigationController?
    var callApiService = HttpUtility()
     var newsData = [NewsData]()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
       
}
    override func viewWillAppear(_ animated: Bool) {
        checkNetwork ()
    }
    
    @IBAction func onClickMenuBtn(_ sender: Any) {
    present(menu!,animated: true, completion: nil )
}

    func setUpTableView(){
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: .main), forCellReuseIdentifier: "NewsTableViewCell")
        kUserDefaults.set("ProfileTab", forKey: AppKeys.tabName)
        
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
    }

    
    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    showActivityIndicator()
                    
                        let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.newsListURL, response: NewsModel.self)
                    dump(response)
                        if response.status == true {
                            newsData = response.data ?? []
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.hideActivityIndicator()
                                self.newsTableView.reloadData()
                               
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
