//
//  CLLocationCoordinate2D+adds.swift
//  IBMWeather
//
//  Created by Mac on 14.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}
