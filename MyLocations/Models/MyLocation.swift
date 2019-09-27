//
//  Database.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class MyLocation: NSObject {
  var id: Int
  var placeTitle: String
  var placeDescription: String
  var coordinates: CLLocationCoordinate2D
  var placeMark: CLPlacemark?

  init(id: Int, title: String, description: String, coordinates: CLLocationCoordinate2D, placemark: CLPlacemark?) {
    self.id = id
    self.placeTitle = title
    self.placeDescription = description
    self.coordinates = coordinates
    self.placeMark = placemark
  }
}

extension MyLocation: MKAnnotation {
  var coordinate: CLLocationCoordinate2D {
    return coordinates
  }
  var title: String? {
    return placeTitle
  }

  var address: String {
      guard let mark = placeMark else {
          return ""
      }

      return "\(mark.subThoroughfare ?? "") \(mark.thoroughfare ?? "") \(mark.locality ?? "") \(mark.administrativeArea ?? "") \(mark.postalCode ?? "")"
  }
}


