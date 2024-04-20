//
//  VideosListVC.swift
//  The_You_Frontier
//
//  Created by CTS on 08/01/24.
//

import UIKit
import CoreLocation
import MapKit

class VideosListVC: UIViewController {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDescription: MyRegularLabel!
    @IBOutlet weak var lblTitle: MyBoldLabel!
    @IBOutlet weak var btnIntrested: UIButton!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var btnViewMore: MyButton!
    @IBOutlet var collectionView: UICollectionView!
    
    
    var itemCount = 4
    var listId : Int!
    var latitude = ""
    var longtitude = ""
    var comingForm = ""
    var showEventIntrest : Int!
    var videosList = [String]()//["img1","img2","img3","img4"]
    var callApiService = HttpUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnViewMore.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        btnIntrested.layer.cornerRadius = 8
        if comingForm == "WorkSpace" {
            btnIntrested.isHidden = true
        }else {
            hideShowIntrestBtn()
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkNetwork ()
       
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func hideShowIntrestBtn(){
        if showEventIntrest == 0 {
            btnIntrested.isHidden = false
        }else{
            btnIntrested.isHidden = true
        }
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork () {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            Task{
                do{
                    showActivityIndicator()
                    
                    if comingForm == "WorkSpace" {
                        let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.workSpaceDetailURL + "\(listId!)" , response: EventDetailModel.self)
                        
                        if response.status == true {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                self.hideActivityIndicator()
                                self.lblTitle.text = response.data?.title ?? ""
                                self.lblDescription.text = response.data?.description ?? ""
                                self.lblAddress.text = response.data?.location ?? ""
                                self.latitude = response.data?.lat ?? ""
                                self.longtitude = response.data?.lng ?? ""
                                self.videosList = response.data?.image_url ?? []
                                if self.videosList.count > 4 {
                                    self.btnViewMore.isHidden = false
                                }else{
                                    self.btnViewMore.isHidden = true
                                }
                                self.collectionView.reloadData()
                            }
                            
                        }
                        else{
                            self.hideActivityIndicator()
                            
                            self.ShowAlert(message: response.message ?? "")
                        }
                    }else{
                        let response = try await callApiService.getOperation(requestUrl: BaseUrl.baseURL + BaseUrl.eventDetailURL + "\(listId!)" , response: EventDetailModel2.self)
                        
                        if response.status == true {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                self.hideActivityIndicator()
                                self.lblTitle.text = response.data?.name ?? ""
                                self.lblDescription.text = response.data?.description ?? ""
                                self.lblAddress.text = response.data?.location ?? ""
                                self.latitude = response.data?.lat ?? ""
                                self.longtitude = response.data?.lng ?? ""
                                self.videosList = response.data?.image_url ?? []
                                
                                let eventTimeDetail = "\(response.data?.event_date ?? "") \(response.data?.event_time ?? "")"
                                let myDate = eventTimeDetail
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date = dateFormatter.date(from: myDate)!
                                dateFormatter.dateFormat = "EEEE, dd MMMM yyyy '| opens at' H:mm a"//"dd/MM/yyyy"

                                let dateString = dateFormatter.string(from: date)
                               // print(dateString)

                                self.lblDate.text = dateString
                                
                                
                                
                                if self.videosList.count > 4 {
                                    self.btnViewMore.isHidden = false
                                }else{
                                    self.btnViewMore.isHidden = true
                                }
                                
                                self.showEventIntrest = response.data?.showinterest_count
                                self.hideShowIntrestBtn()
                                self.collectionView.reloadData()

                            }
                            
                        }
                        else{
                            self.hideActivityIndicator()
                            
                            self.ShowAlert(message: response.message ?? "")
                        }
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
    
    override func viewDidLayoutSubviews() {
        
        if self.videosList.count <= 2 {
            self.collectionHeight.constant = 200
        }else{
            self.collectionHeight.constant = 380
            
        }
        self.collectionView.reloadData()
    }

    @IBAction func backActionBtn(_ sender: UIButton) {
        popViewController()
    }
    
    
    @IBAction func btnIntrestedAction(_ sender: UIButton) {
        let vc = LikePopUpScreen.instantiate(fromAppStoryboard: .map)
        vc.listId = listId
        vc.eventDetailProtocol = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true)
        
    }
    
    @IBAction func btnGetStartedAction(_ sender: MyButton) {
        
        openGoogleMap(lat: latitude, long: longtitude, address: self.lblAddress.text!)
        
//        let vc = MapVC.instantiate(fromAppStoryboard: .map)
//        vc.comingFrom = "VideoListVC"
//        pushToVC(vc, animated: true)
    }
    
    @IBAction func onClickViewMore(_ sender: Any) {
        let vc = ShowEventImagesVC.instantiate(fromAppStoryboard: .map)
        vc.videosList = videosList
        vc.videoTitle = self.lblTitle.text!
        pushToVC(vc, animated: true)
    }
    
    func openGoogleMap(lat:String,long:String, address :String) {
        
        //var strLat1 = "28.628151"
        //var strLong2 = "77.367783"
        let strLat1 = lat
        let strLong2 = long
        
//        guard let url = URL(string:"http://maps.apple.com/?daddr=\(strLat1),\(strLong2)") else { return }
//        UIApplication.shared.open(url)
        
        let latitude = Double(strLat1)
        let longititude = Double(strLong2)
            
        let coordinate = CLLocationCoordinate2DMake(latitude!,longititude!)
                        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
                        mapItem.name = address
                        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
        
}


extension VideosListVC : EventDetailProtocol {
    func callApiService(setValue: Bool) {
        if setValue == true {
            checkNetwork()
        }
    }
    
    
}
