//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsViewController: UITableViewController {
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return StaticDatabase.myLocations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else {
      return UITableViewCell()
    }
    
    let myLocation = StaticDatabase.myLocations[indexPath.row]
    cell.configure(myLocation: myLocation)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      StaticDatabase.myLocations.remove(at: indexPath.row)
      tableView.reloadData()
    default:
      return
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EditLocation",
      let controller = segue.destination as? LocationDetailViewController,
      let sender = sender as? UITableViewCell,
      let indexPath = tableView.indexPath(for: sender) {
      let myLocation = StaticDatabase.myLocations[indexPath.row]
      controller.myLocationSaved = myLocation
    }
  }
  
}
