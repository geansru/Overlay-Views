//
//  ParkMapOverlayView.swift
//  Park View
//
//  Created by Dmitriy Roytman on 06.09.17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlayView: MKOverlayRenderer {
  var overlayImage: UIImage
  
  init(overlay: MKOverlay, overlayImage: UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }
  
  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    guard let imageReference = overlayImage.cgImage else { return }
    
    let rectangle = rect(for: overlay.boundingMapRect)
    
    context.scaleBy(x: 1, y: -1)
    context.translateBy(x: 0, y: -rectangle.size.height)
    context.draw(imageReference, in: rectangle)
  }
}
