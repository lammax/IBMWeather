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
    var city: String

    init(title: String?, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, imageID: String, city: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = UIImage(named: imageID)
        self.city = city
    }
}
