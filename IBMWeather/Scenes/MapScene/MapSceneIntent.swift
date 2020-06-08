//
//  MapSceneIntent.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI
import CoreLocation
import Combine


class MapSceneIntent: ObservableObject {
    
    @Published var checkpoints: [Checkpoint] = []
    @Published var currentLocation: CLLocationCoordinate2D?

    private let webservice = Webservice.sharedInstance
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        LocationManager.sharedInstance.delegate = self
        setupPublishers()
    }
    
    private func setupPublishers() {
        
        let cancellableCurrent = $currentLocation
        .compactMap { $0 }
        .flatMap { location in
            self.webservice.fetchWeather(location: location, t: CurrentWeather())
                .catch { error in Just(CurrentWeather.placeholder) }
                .map { ($0, location) }
        }
        .sink {
            if let weather = $0.0 {
                let title = weather.forecast?.narrative_32char ?? "No title"
                let subtitle = weather.forecast?.narrative_512char ?? "No subtitle"
                let newCheckPoint = Checkpoint(title: subtitle, subtitle: title, coordinate: $0.1)
                self.checkpoints += [newCheckPoint]
            }
        }

        self.cancellables.append(cancellableCurrent)
    }
    
}

extension MapSceneIntent: LocationManagerDelegate {
    func update(location: CLLocation) {
        if self.currentLocation == nil {
            self.currentLocation = location.coordinate
        }
    }
}
