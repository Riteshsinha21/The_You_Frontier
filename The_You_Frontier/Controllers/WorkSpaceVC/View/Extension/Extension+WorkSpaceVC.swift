//
//  Extension+WorkSpaceVC.swift
//  The_You_Frontier
//
//  Created by Chawtech on 10/01/24.
//

import Foundation
import UIKit
import CoreLocation
import SDWebImage

extension WorkSpaceVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workSpaceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(EventListTblCell.self, for: indexPath)
    
        let data = workSpaceData[indexPath.row]
        
        cell.eventTitle.text = data.title ?? ""
        cell.eventDetail.text = data.location ?? ""
        cell.eventTime.text = data.description ?? ""
        cell.btnViewEvent.setTitleColor(UIColor.white, for: .normal)
        cell.eventDetail.textColor = UIColor.bgColor
        
      
        if data.image_url?.count != 0 {
            
            var str1 = data.image_url?.first
            let urlStr = BaseUrl.imageBaseUrl + (str1 ?? "")
            
            if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: urlString) {
                    // Use the cleaned URL
                    cell.eventImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Mask group-4"))
                    
                }
            }
        }
        else{
            cell.eventImage.image = UIImage(named: "Mask group 1")
        }

        cell.eventTime.textColor = UIColor.white
        cell.btnViewEvent.tag = indexPath.row
        cell.btnViewEvent.addTarget(self, action: #selector(viewActionBtn(_sender: )), for: .touchUpInside)
        return cell
    }
    
    @objc func viewActionBtn( _sender: UIButton){
        let vc = VideosListVC.instantiate(fromAppStoryboard: .map)
        vc.listId = workSpaceData[_sender.tag].id
        vc.comingForm = "WorkSpace"
        self.pushToVC(vc, animated: true)
    }
    
}

// MARK: This is used for fetch current location

extension WorkSpaceVC : CLLocationManagerDelegate {
     
    
    // MARK: - CoreLocation Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                print("When user did not yet determined")
            case .restricted:
                print("Restricted by parental control")
            case .denied:
                print("When user select option Dont't Allow")
            case .authorizedAlways:
                print("Geofencing feature has user permission")
            case .authorizedWhenInUse:
                // Request Always Allow permission
                // after we obtain When In Use permission
                self.locationManager.requestAlwaysAuthorization()
            default:
                print("default")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = "\(locValue.latitude)"
        self.longitude = "\(locValue.longitude)"
        
        checkNetwork (params: WorkSpaceLocationModel.init(lat: self.latitude ,lng: self.longitude ))
        
        manager.stopUpdatingLocation()
        let location = locations[0]
      geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
          if (error != nil) {
              print("Error in reverseGeocode")
              }
         let placemark1 = placemarks
          if placemark1 != nil {
              let placemark = placemarks! as [CLPlacemark]
              
              if placemark.count > 0 {
                  let placemark = placemarks![0]
                  self.locality = placemark.locality!
                  self.administrativeArea = placemark.subLocality!
                  self.country = placemark.country!
              }
              self.textSearchWorkSpace.textColor = UIColor.black
              self.textSearchWorkSpace.text = "\(self.locality) " + "\(self.administrativeArea)"
          }
      
      })
       
    }

}
