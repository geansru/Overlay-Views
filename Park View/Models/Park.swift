//
//  Park.swift
//  Park View
//
//  Created by Dmitriy Roytman on 06.09.17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

final class Park {
  var name: String?
  var boundary: [CLLocationCoordinate2D] = []
  var midCoordinate = CLLocationCoordinate2D()
  var overlayTopLeftCoordinate = CLLocationCoordinate2D()
  var overlayTopRightCoordinate = CLLocationCoordinate2D()
  var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
  var overlayBottomRightCoordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude, overlayTopRightCoordinate.latitude)
  }

  var overlayBoundingMapRect: MKMapRect {
    let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
    let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
    let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
    
    return MKMapRectMake(topLeft.x, topLeft.y, fabs(topLeft.x - topRight.x), fabs(topLeft.y - bottomLeft.y))
  }
  
  // MARK: initilizers
  init(filename: String) {
    guard let properties = Park.plist(filename) as? [String: Any] else { return }
    guard let boundaryPoints = properties["boundary"] as? [String] else { return }
    midCoordinate = Park.parseCoord(dict: properties, fieldName: "midCoord")
    overlayTopLeftCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayTopLeftCoord")
    overlayTopRightCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayTopRightCoord")
    overlayBottomLeftCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayBottomLeftCoord")
    
    let cgPoints = boundaryPoints.map { CGPointFromString($0)}
    boundary = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
  }
}

// MARK: deserializer and helper method
extension Park {
  class func plist(_ plist: String) -> Any? {
    guard let filePath = Bundle.main.path(forResource: plist, ofType: "plist") else { return nil }
    guard let data = FileManager.default.contents(atPath: filePath) else { return nil }
    let propertyList = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    return propertyList
  }
  
  static func parseCoord(dict: [String:Any], fieldName: String) -> CLLocationCoordinate2D {
    guard let coord = dict[fieldName] as? String else { return CLLocationCoordinate2D() }
    let point = CGPointFromString(coord)
    return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
  }
}
