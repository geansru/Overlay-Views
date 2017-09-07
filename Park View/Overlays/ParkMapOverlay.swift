//
//  ParkMapOverlay.swift
//  Park View
//
//  Created by Dmitriy Roytman on 06.09.17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

final class ParkMapOverlay: NSObject, MKOverlay {
  var coordinate: CLLocationCoordinate2D
  var boundingMapRect: MKMapRect
  
 init(park: Park) {
    boundingMapRect = park.overlayBoundingMapRect
    coordinate = park.midCoordinate
  }
  
}
