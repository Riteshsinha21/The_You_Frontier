//
//  MapVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 31/01/24.
//

import UIKit
import SideMenu
import MapKit

struct MarkerStruct {
    let name: String
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
}

class MapVC: UIViewController, MKMapViewDelegate {
    
    var comingFrom = ""
    var markUpData = [WorkSpaceData]()
    var menu: SideMenuNavigationController?
    var userLatitude = Double()
    var userLongitude = Double()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var textSearchWorkSpace: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        mapView.delegate = self
//        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        
        //        let initialLocation = CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude)
        //        let initialRegion = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
        //        mapView.setRegion(initialRegion, animated: true)
        
        for marker in markUpData {
            
            let london = MKPointAnnotation()
            london.title = marker.location
            let latitude = Double(marker.lat ?? "")
            let longititude = Double(marker.lng ?? "")
            london.coordinate = CLLocationCoordinate2D(latitude:latitude!, longitude: longititude! )
            mapView.addAnnotation(london)
            
            
        }
        
        self.zoomAccToAnnotation()
        
    }
    
    func zoomAccToAnnotation() {
        
        let allAnnotations = mapView.annotations
        
        // If there are annotations, calculate the region that fits all of them
        if !allAnnotations.isEmpty {
            var zoomRect = MKMapRect.null
            for annotation in allAnnotations {
                let annotationPoint = MKMapPoint(annotation.coordinate)
                let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
                zoomRect = zoomRect.union(pointRect)
            }
            
            // Optionally, include the user's location in the visible region
            if let userLocation = locationManager.location {
                let userPoint = MKMapPoint(userLocation.coordinate)
                let userRect = MKMapRect(x: userPoint.x, y: userPoint.y, width: 0, height: 0)
                zoomRect = zoomRect.union(userRect)
            }
            
            // Set the region to fit all annotations and optionally the user's location
            let edgeInsets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            mapView.setVisibleMapRect(zoomRect, edgePadding: edgeInsets, animated: true)
        }
    }
    
    func setUpUI() {
        
        if comingFrom == "WorkspaceVC"{
            backBtn.setImage(UIImage(named: "blackBackArrow"), for: .normal)
            let name = kUserDefaults.value(forKey: AppKeys.name) as! String
            profileBtn.setTitle(name.first?.uppercased(), for: .normal)
            topView.backgroundColor = UIColor.clear
            profileBtn.isHidden = true
        }else{
            backBtn.setImage(UIImage(named: "blackBackArrow"), for: .normal)
            profileBtn.setImage(UIImage(named: "cross"), for: .normal)
            profileBtn.setTitle("", for: .normal)
            topView.backgroundColor = UIColor.white
            topView.layer.cornerRadius = 20
            
        }
        profileBtn.makeRounded()
        textSearchWorkSpace.layer.cornerRadius = 20
        
        textSearchWorkSpace.backgroundColor = UIColor.white
        
        
        
        //MARK:- Side Menu
        
        menu = SideMenuNavigationController(rootViewController: SideMenuListVC())
        menu?.presentationStyle = .menuSlideIn
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.menuWidth = 300
    }
    
    @IBAction func profileActionBtn(_ sender: UIButton) {
        // tabBarController?.selectedIndex = 4
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        if comingFrom == "WorkspaceVC"{
            popViewController()
//            present(menu!,animated: true, completion: nil )
        }else{
            popViewController()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//            let location = locations.last as! CLLocation
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//            region.center = mapView.userLocation.coordinate
//            mapView.setRegion(region, animated: true)
        }
    
    
}
