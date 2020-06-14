//
//  Constants.swift
//  IBMWeather
//
//  Created by Mac on 09.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import CoreLocation

struct Constants {
    
    enum Units: String, Decodable {
        case metric = "m"
        case imperial = "e"
    }
    
    enum Lang: String, Decodable {
        case ru = "ru-RU"
        case us = "en-US"
    }
    
    enum ForecastCurrent: String {
        case nowcast
        case fifteenminute
    }
    
    enum ForecastDaily: String {
        case daily3day = "3day"
        case daily5day = "5day"
        case daily7day = "7day"
        case daily10day = "10day"
        case daily15day = "15day"
    }
    
    /*enum IconType: String {
        case png
        case jpg
        case bmp
        case gif
        case tiff
    }*/
    
    //MARK: Current example
    //15 minutes
    //https://api.weather.com/v1/geocode/34.063/-84.217/forecast/fifteenminute.json?language=ru-RU&units=m&apiKey=2d6b51b925ac4b60ab51b925ac0b605e
    //current weather
    //https://api.weather.com/v1/geocode/56.8619/35.8931/forecast/nowcast.json?language=en-US&units=m&apiKey=2d6b51b925ac4b60ab51b925ac0b605e

    //MARK: Daily example
    //15 Daily forecast
    //https://api.weather.com/v3/wx/forecast/daily/15day?geocode=33.74,-84.39&format=json&units=m&language=ru-RU&apiKey=2d6b51b925ac4b60ab51b925ac0b605e
    
    //MARK: LocationPoint
    //https://api.weather.com/v3/location/point?geocode=56.8619,35.8931&language=ru-RU&format=json&apiKey=2d6b51b925ac4b60ab51b925ac0b605e
    
    struct URLs {
        
        private let weatherAPI: String = "2d6b51b925ac4b60ab51b925ac0b605e"
        private let baseCurrentURL: String = "https://api.weather.com/v1/"
        private let baseDailyURL: String = "https://api.weather.com/v3/wx/forecast/daily/"
        private let baseLocationURL: String = "https://api.weather.com/v3/location/point?"

        var weather: String = ""
        
        init(forecastCurrent: ForecastCurrent, location: CLLocationCoordinate2D, unit: Units = .metric, lang: Lang = .ru) {
            weather = baseCurrentURL
            weather += "geocode/\(location.latitude)/\(location.longitude)/"
            weather += "forecast/\(forecastCurrent.rawValue).json?"
            weather += "language=\(lang.rawValue)"
            weather += "&units=\(unit.rawValue)"
            weather += "&apiKey=\(weatherAPI)"
        }
        
        init(forecastDaily: ForecastDaily, location: CLLocationCoordinate2D, unit: Units = .metric, lang: Lang = .ru) {
            weather = baseDailyURL
            weather += "\(forecastDaily.rawValue)?"
            weather += "geocode=\(location.latitude),\(location.longitude)&"
            weather += "format=json&"
            weather += "units=\(unit.rawValue)&"
            weather += "language=\(lang.rawValue)&"
            weather += "apiKey=\(weatherAPI)"
        }

        init(locationPoint: CLLocationCoordinate2D, unit: Units = .metric, lang: Lang = .ru) {
            weather = baseLocationURL
            weather += "geocode=\(locationPoint.latitude),\(locationPoint.longitude)&"
            weather += "language=\(lang.rawValue)&"
            weather += "format=json&"
            weather += "apiKey=\(weatherAPI)"
        }

    }
    
}
