//
//  CurrentLocationViewController.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController {
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!

  @IBOutlet weak var getLocationButton: UIButton!
  @IBOutlet weak var tagLocationButton: UIButton!
  
  private let locationManager = CLLocationManager()
  private let geocoder = CLGeocoder()
  private var isRunningReverseGeocoding = false
  private var isUpdatingLocation = false
  
  private var myLocation: MyLocation? {
    didSet {
      updateButtons()
      updateLabels()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateButtons()
  }
  
  @IBAction func tagLocation() {
    print("Clicked in tag location")
  }
  
  @IBAction func getLocation() {
    print("Clicked in get location")
    if isUpdatingLocation {
      stopManagerLocation()
    } else {
      checkAuthPermissions()
      startManagerLocation()
    }
    
    updateButtons()
  }

  private func updateButtons() {
    tagLocationButton.isEnabled = myLocation != nil && !isUpdatingLocation
    getLocationButton.setTitle(isUpdatingLocation ? "Stop" : "Get My Location", for: .normal)
  }
  
  private func updateLabels() {
    guard let location = myLocation else {
        return
    }
    
    latitudeLabel.text = String(format: "%.4f", location.coordinates.latitude)
    longitudeLabel.text = String(format: "%.4f", location.coordinates.longitude)
    addressLabel.text = location.address
  }
  
  private func checkAuthPermissions() {
    let authStatus = CLLocationManager.authorizationStatus()
    if authStatus == .notDetermined {
        locationManager.requestWhenInUseAuthorization()
        return
    }
    
    if authStatus == .denied || authStatus == .restricted {
        checkErrorAlert()
        return
    }
  }
  
  private func checkErrorAlert() {
      let alertViewController = UIAlertController(title: "Permissions denied", message: "Please enable location permissions in app settings", preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertViewController.addAction(okAction)
      present(alertViewController, animated: true, completion: nil)
  }
  
  
  private func startManagerLocation() {
    if CLLocationManager.locationServicesEnabled() {
      isUpdatingLocation = true
      locationManager.delegate = self
      locationManager.startUpdatingLocation()
    }
  }
  
  private func stopManagerLocation() {
    isUpdatingLocation = false
    locationManager.stopUpdatingLocation()
  }
  
  private func runReverseGeocoding(forLocation location: CLLocation) {
    if !isRunningReverseGeocoding {
        isRunningReverseGeocoding = true
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
          self.isRunningReverseGeocoding = false
          if let error = error {
              print(error)
              return
          }
          
          guard let marks = placemarks, let mark = marks.last else {
              return
          }
          
          self.myLocation?.placeMark = mark
          self.updateLabels()
        }
    }
  }
}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let lastLocation = locations.last else {
          return
      }
        
      runReverseGeocoding(forLocation: lastLocation)
      myLocation = MyLocation(id: 0, title: "", description: "", coordinates: lastLocation.coordinate, placemark: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("didFailLocationManager")
    }
}

