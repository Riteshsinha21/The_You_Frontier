//
//  Extension+WorkSpaceVC+SearchPlace.swift
//  The_You_Frontier
//
//  Created by Chawtech on 11/01/24.
//

import Foundation
import GooglePlaces

extension WorkSpaceVC: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
      
      let geocoder = CLGeocoder()
      let locValue: CLLocationCoordinate2D = place.coordinate
      
          print("locations with lat & long = \(locValue.latitude) \(locValue.longitude) \(place.name ?? "")")
      self.latitude = "\(locValue.latitude)"
      self.longitude = "\(locValue.longitude)"
      
      checkNetwork (params: WorkSpaceLocationModel.init(lat: self.latitude ,lng: self.longitude ))
      
      let latitude = locValue.latitude // Replace with the latitude of your location
      let longitude = locValue.longitude // Replace with the longitude of your location
      let location = CLLocation(latitude: latitude, longitude: longitude)

      geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
          if let error = error {
              print("Reverse geocoding error: \(error.localizedDescription)")
              return
          }

          if let placemark = placemarks?.first {
              if let city = placemark.locality {
                  print("City: \(city)")
                  self.locality = city
                 
              }
              
              if let state = placemark.subLocality {
                  print("State: \(state)")
                  self.administrativeArea = placemark.subLocality!
                  

                  
              }
              if let country = placemark.country {
                  print("Country: \(country)")

                 
              }
              if let postCode = placemark.postalCode {
                  print("PostCode: \(postCode)")

              }
          }
          
          self.textSearchWorkSpace.textColor = UIColor.black
          self.textSearchWorkSpace.text = "\(self.locality) " + "\(self.administrativeArea)"
      }


    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

 
}
