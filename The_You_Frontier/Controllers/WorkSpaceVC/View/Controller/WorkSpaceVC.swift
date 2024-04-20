//
//  WorkSpaceVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import UIKit
import CoreLocation
import GooglePlaces
import SideMenu

class WorkSpaceVC: UIViewController {
    
    //MARK: Properties
    var locality = ""
    var country = ""
    var administrativeArea = ""
    let geocoder = CLGeocoder()
    var callApiService = HttpUtility()
    let locationManager = CLLocationManager()
    var menu: SideMenuNavigationController?
    var workSpaceData = [WorkSpaceData]()
    var latitude = ""
    var longitude = ""
    
    
    
    //MARK: Outlest
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var workSpaceTableView: UITableView!
    @IBOutlet weak var textSearchWorkSpace: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kUserDefaults.set("ProfileTab", forKey: AppKeys.tabName)
        let name = kUserDefaults.value(forKey: AppKeys.name) as! String
        profileBtn.setTitle(name.first?.uppercased(), for: .normal)
        
        setUpTableView()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
            
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        searchView.addGestureRecognizer(tap)
        
        searchView.isUserInteractionEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("locations = \(self.latitude) \(self.longitude)")
     
    }
    //MARK:-  check internet Connection
    
    func checkNetwork (params:Encodable) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            
            Task{
                do{
                    showActivityIndicator()
                    
                    let response = try await callApiService.postOperation(sendHeader: true, requestMethod: .post, params:params ,requestUrl: BaseUrl.baseURL + BaseUrl.workSpaceListURL, response: WorkSpaceListModel.self)

                    if response.status == true {
                        workSpaceData = response.data ?? []
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.hideActivityIndicator()
                            self.workSpaceTableView.reloadData()
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
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        present(autocompleteController, animated: true, completion: nil)
        
        
    }
    
    func setUpTableView(){
        workSpaceTableView.delegate = self
        workSpaceTableView.dataSource = self
        profileBtn.makeRounded()
        textSearchWorkSpace.layer.cornerRadius = 20
        
        textSearchWorkSpace.backgroundColor = UIColor.white
        workSpaceTableView.register(UINib(nibName: "EventListTblCell", bundle: .main), forCellReuseIdentifier: "EventListTblCell")
        
        //MARK:- Side Menu
        
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.menuWidth = 300
        
    }

    @IBAction func profileActionBtn(_ sender: UIButton) {
        tabBarController?.selectedIndex = 4
    }
    
    @IBAction func btnViewMapAction(_ sender: UIButton) {
        
        let vc = MapVC.instantiate(fromAppStoryboard: .map)
        vc.comingFrom = "WorkspaceVC"
        vc.markUpData = workSpaceData
        vc.userLatitude = Double(self.latitude) ?? 0.0
        vc.userLongitude = Double(self.longitude) ?? 0.0
        pushToVC(vc, animated: true)
    }
    
    @IBAction func menuActionBtn(_ sender: UIButton) {
        present(menu!,animated: true, completion: nil )
    }
    
    @IBAction func onClickSideMenuBtn(_ sender: UIButton) {
        
    }
}

