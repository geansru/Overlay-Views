//
//  AttractionAnnotationView.swift
//  Park View
//
//  Created by Dmitriy Roytman on 06.09.17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import MapKit

class AttractionAnnotationView: MKAnnotationView {
  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    guard let attractionAnnotation = self.annotation as? AttractionAnnotation else { return }
    image = attractionAnnotation.type.image
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
