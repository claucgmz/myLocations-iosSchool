//
//  MapViewController.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewWillAppear(_ animated: Bool) {
    if !StaticDatabase.myLocations.isEmpty {
      showLocations()
    }
  }
  
  @IBAction func showLocations() {
    mapView.removeAnnotations(StaticDatabase.myLocations)
    mapView.addAnnotations(StaticDatabase.myLocations)
  }
  
  @IBAction func showUserLocation() {
    let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(mapView.regionThatFits(region), animated: true)
  }
}

extension MapViewController: MKMapViewDelegate {
  
}
