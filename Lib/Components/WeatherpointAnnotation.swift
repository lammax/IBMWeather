//
//  Checkpoint.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import CoreLocation
import MapKit

final class WeatherpointAnnotation: NSObject, MKAnnotation {
    var title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let image: UIImage!
    
    var mainText: String {
        willSet {
            if !newValue.isEmpty {
                self.title = city + " " + newValue
            }
        }
    }
    var city: String {
        willSet {
            if !newValue.isEmpty {
                self.title = newValue + " " + mainText
            }
        }
    }

    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, imageID: String, mainText: String = "", city: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = UIImage(named: imageID)
        self.mainText = mainText
        self.city = city
    }
}
