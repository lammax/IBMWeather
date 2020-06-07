//
//  MapSceneIntent.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI
import CoreLocation


class MapSceneIntent: ObservableObject {
    
    @Published var checkpoints: [Checkpoint] = [
      Checkpoint(title: "Tver", coordinate: .init(latitude: 56.8619, longitude: 35.8931))
    ]
    
    init() {
        LocationManager.sharedInstance.delegate = self
    }
    
}

extension MapSceneIntent: LocationManagerDelegate {
    func update(location: CLLocation) {
        self.checkpoints = [
            Checkpoint(title: "Tver", coordinate: .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        ]
    }
}
