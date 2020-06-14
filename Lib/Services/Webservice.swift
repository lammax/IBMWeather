//
//  Webservice.swift
//  IBMWeather
//
//  Created by Mac on 09.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import Combine
import CoreLocation


class Webservice {
    
    static let sharedInstance = Webservice()
    
    let decoder = JSONDecoder()

    init() {
        /*decoder.dateDecodingStrategy = .custom({ (d) -> Date in
            let container = try d.singleValueContainer()
            let dateStr = try container.decode(String.self)
            // possible date strings: "2016-05-01",  "2016-07-04T17:37:21.119229Z", "2018-05-20T15:00:00Z"
            var date: Date? = nil
            if dateStr.contains("T") {
                date = Date.dateFormatterWithTime.date(from: dateStr)
            } else {
                date = Date(timeIntervalSince1970: Double(Int(dateStr) ?? 0))
            }
            guard let date_ = date else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
            }
            print("DATE DECODER \(dateStr) to \(date_)")
            return date_
        })*/
    }

    
    func fetchWeather<T: Decodable>(forecastCurrent: Constants.ForecastCurrent, location: CLLocationCoordinate2D, t: T) -> AnyPublisher<T?, Error> {
        guard let url = URL(string: Constants.URLs(forecastCurrent: forecastCurrent, location: location).weather) else { fatalError("Invalid weather URL!") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchWeather<T: Decodable>(forecastDaily: Constants.ForecastDaily, location: CLLocationCoordinate2D, t: T) -> AnyPublisher<T?, Error> {
        guard let url = URL(string: Constants.URLs(forecastDaily: forecastDaily, location: location).weather) else { fatalError("Invalid weather URL!") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchWeather<T: Decodable>(locationPoint: CLLocationCoordinate2D, t: T) -> AnyPublisher<T?, Error> {
        guard let url = URL(string: Constants.URLs(locationPoint: locationPoint).weather) else { fatalError("Invalid weather URL!") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

