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
    
    @Published var checkpoints: [WeatherpointAnnotation] = []
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
            self.webservice.fetchWeather(forecastCurrent: .fifteenminute, location: location, t: Weather15Minutes())
                .catch { error in Just(Weather15Minutes.placeholder) }
                .map { ($0, location) }
        }
        .sink {
            if let weather = $0.0, let forecast = weather.forecasts?.first {
                let title = "\(forecast.temp ?? 0) C"
                let subtitle = forecast.phrase_32char ?? ""
                let imageID = "\(forecast.icon_code ?? 44)"
                let newCheckPoint = WeatherpointAnnotation(title: title, subtitle: subtitle, coordinate: $0.1, imageID: imageID)
                self.checkpoints += [newCheckPoint]
            }
        }

        let cancellableDaily = $currentLocation
        .compactMap { $0 }
        .flatMap { location in
            self.webservice.fetchWeather(forecastDaily: .daily15day, location: location, t: WeatherDaily())
                .catch { error in Just(WeatherDaily.placeholder) }
                .map { $0 }
        }
        .sink {
            if let weather = $0, let dailyPart = weather.daypart?.first {
                print(dailyPart?.iconCode?.count ?? 0)
            }
        }

        let cancellableLocationPoint = $currentLocation
        .compactMap { $0 }
        .flatMap { location in
            self.webservice.fetchWeather(locationPoint: location, t: LocationPoint())
                .catch { error in Just(LocationPoint.placeholder) }
                .map { $0 }
        }
        .sink {
            if let locationPoint = $0?.location {
                print(locationPoint.city ?? "No city")
            }
        }

        self.cancellables.append(cancellableCurrent)
        self.cancellables.append(cancellableDaily)
        self.cancellables.append(cancellableLocationPoint)
    }
    
}

extension MapSceneIntent: LocationManagerDelegate {
    func update(location: CLLocation) {
        if self.currentLocation == nil {
            self.currentLocation = location.coordinate
        }
    }
}
