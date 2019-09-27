//
//  LocationDetailViewController.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDetailViewController: UITableViewController {
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  var newLocation: MyLocation?
  var myLocationSaved: MyLocation? 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let location = newLocation {
      setLabelsForLocation(myLocation: location)
      return
    }
    
    if let location = myLocationSaved {
      setLabelsForLocation(myLocation: location)
    }
  }
  
  private func setLabels(forCoordinates coordinates: CLLocationCoordinate2D, placemark: CLPlacemark?) {
    latitudeLabel.text = String(format: "%.4f", coordinates.latitude)
    longitudeLabel.text = String(format: "%.4f", coordinates.longitude)
    
    guard let placemark = placemark else {
      addressLabel.text = "No Address Found"
      return
    }
    
    addressLabel.text = placemark.addressString
  }
  
  private func setLabelsForLocation(myLocation: MyLocation) {
    setLabels(forCoordinates: myLocation.coordinates, placemark: myLocation.placeMark)
    titleTextField.text = myLocation.title
    descriptionTextView.text = myLocation.placeDescription
  }
  
  @IBAction func done() {
    
    if let savedLocation = myLocationSaved {
      savedLocation.placeTitle = titleTextField.text ?? ""
      savedLocation.placeDescription = descriptionTextView.text ?? ""
      StaticDatabase.myLocations[savedLocation.id] = savedLocation
    }
    
    if let newLocation = newLocation {
      newLocation.placeTitle = titleTextField.text ?? ""
      newLocation.placeDescription = descriptionTextView.text ?? ""
      newLocation.id = StaticDatabase.myLocations.count
      StaticDatabase.myLocations.append(newLocation)
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func cancel() {
    navigationController?.popViewController(animated: true)
  }
}


extension CLPlacemark {
  var addressString: String {
    return "\(self.subThoroughfare ?? "") \(self.thoroughfare ?? "") \(self.locality ?? "") \(self.administrativeArea ?? "") \(self.postalCode ?? "")"
  }
}

extension Date {
  var string: String {
    let dateFormatter = DateFormatter()
    return dateFormatter.string(from: self)
  }
}
