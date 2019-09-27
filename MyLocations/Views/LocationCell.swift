//
//  LocationCell.swift
//  MyLocations
//
//  Created by Claudia Carrillo on 9/20/19.
//  Copyright © 2019 Claudia Carrillo. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
  static var identifier = "LocationCell"
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  func configure(myLocation: MyLocation) {
    titleLabel.text = myLocation.title
    addressLabel.text = myLocation.address
  }
}

