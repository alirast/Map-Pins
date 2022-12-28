//
//  Capital.swift
//  Map Pins
//
//  Created by n on 03.10.2022.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var info: String
    var coordinate: CLLocationCoordinate2D
    var wikiData: String
    
    init(title: String, info: String, coordinate: CLLocationCoordinate2D, wikiData: String) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
        self.wikiData = wikiData
    }
}
