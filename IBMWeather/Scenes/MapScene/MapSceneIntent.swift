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
    private var settings: CommonSettings?
    
    init() {
        LocationManager.sharedInstance.delegate = self
        setupPublishers()
    }
    
    func setup(settings: CommonSettings) {
        self.settings = settings
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
            if let weather = $0.0, let forcasts =  weather.forecasts, let forecastFirst = forcasts.first {
                
                self.addFirstFour(forcasts: forcasts)
                self.addHours(forcasts: forcasts)
                
                let title = (self.settings?.city ?? "") + " " + "\(forecastFirst.temp ?? 0) C"
                let mainText = "\(forecastFirst.temp ?? 0) C"
                let subtitle = forecastFirst.phrase_32char ?? ""
                let imageID = "\(forecastFirst.icon_code ?? 44)"
                let newCheckPoint = WeatherpointAnnotation(title: title, subtitle: subtitle, coordinate: $0.1, imageID: imageID, mainText: mainText)
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
            if let weather = $0, let dayPart = weather.daypart?.first, let dp = dayPart {
                self.addDays(wDay: weather, dayPart: dp)
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
                let location = locationPoint.city ?? locationPoint.country ?? ""
                self.settings?.city = location
                if let checkPoint = self.checkpoints.last, checkPoint.city.isEmpty {
                    checkPoint.city = location
                }
            }
        }

        self.cancellables.append(cancellableCurrent)
        self.cancellables.append(cancellableDaily)
        self.cancellables.append(cancellableLocationPoint)
    }
    
    private func addFirstFour(forcasts: [Weather15MinutesForecast]?) {
        settings?.weatherItemsFirst4 = []
        if let forcasts = forcasts, forcasts.count > 3 {
            for i in 0...3 {
                settings?.weatherItemsFirst4.append(item15(forcast: forcasts[i]))
            }
        }
    }
    
    private func addHours(forcasts: [Weather15MinutesForecast]?) {
        settings?.weatherItemsHours = []
        if let forcasts = forcasts, forcasts.count > 4 {
            for i in stride(from: 4, to: forcasts.count-1, by: 4) {
                settings?.weatherItemsFirst4.append(item15(forcast: forcasts[i]))
            }
        }
    }

    private func addDays(wDay: WeatherDaily, dayPart: DayPart) {
        settings?.weatherItemsDays = []
        if let days = wDay.dayOfWeek, days.count > 0 {
            for i in 1...days.count-1 {
                let dpId = i * 2
                let date = "D" + (Date.dateFormatterWithTime.date(from: wDay.validTimeLocal?[i] ?? "") ?? Date()).toString(with: .dayMonth)
                let image = Image(uiImage: UIImage(named: "\(dayPart.iconCode?[dpId] ?? 44)")!.resizedImage(for: CGSize(width: 40, height: 40)))
                let temp = "t=\(dayPart.temperature?[dpId] ?? 0)C"
                let wspd = "\(dayPart.windSpeed?[dpId] ?? 0)m/s"
                let wdir_cardinal = "\(dayPart.windDirectionCardinal?[dpId] ?? "")"
                let wind = "W=\(wspd),\(wdir_cardinal)"
                let rh = "H=\(dayPart.relativeHumidity?[dpId] ?? 0)%"
                let item = WeatherItem(date: date, icon: image, temp: temp, wind: wind, humidity: rh)
                settings?.weatherItemsDays.append(item)
            }
        }
    }
    
    private func item15(forcast: Weather15MinutesForecast) -> WeatherItem {
        let date = "T" + (Date.dateFormatterWithTime.date(from: forcast.fcst_valid_local ?? "") ?? Date()).toString(with: .timeShort)
        let image = Image(uiImage: UIImage(named: "\(forcast.icon_code ?? 44)")!.resizedImage(for: CGSize(width: 40, height: 40)))
        let temp = "t=\(forcast.temp ?? 0)C"
        let wspd = "\(forcast.wspd ?? 0)m/s"
        let wdir_cardinal = "\(forcast.wdir_cardinal ?? "")"
        let wind = "W=\(wspd),\(wdir_cardinal)"
        let rh = "H=\(forcast.rh ?? 0)%"
        return WeatherItem(date: date, icon: image, temp: temp, wind: wind, humidity: rh)
    }

}

extension MapSceneIntent: LocationManagerDelegate {
    func update(location: CLLocation) {
        if self.currentLocation == nil {
            self.currentLocation = location.coordinate
        }
    }
}
