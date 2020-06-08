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
    
    enum FormFactor: String {
        case currentWeather
        case forecast
    }
    
    enum IconType: String {
        case png
        case jpg
        case bmp
        case gif
        case tiff
    }

    struct URLs {
        //current weather
        //https://api.weather.com/v1/geocode/56.8619/35.8931/forecast/nowcast.json?language=en-US&units=m&apiKey=2d6b51b925ac4b60ab51b925ac0b605e
        private let weatherAPI: String = "2d6b51b925ac4b60ab51b925ac0b605e"
        private let baseURL: String = "https://api.weather.com/v1/"

        var weather: String = ""
        //var icon: String = ""
        
        init(location: CLLocationCoordinate2D, unit: Units = .metric, lang: Lang = .us) {
            weather += baseURL
            weather += "geocode/\(location.latitude)/\(location.longitude)/"
            weather += "forecast/nowcast.json?"
            weather += "language=\(lang.rawValue)"
            weather += "&units=\(unit.rawValue)"
            weather += "&apiKey=\(weatherAPI)"
            //print(weather)
        }
        
        /*private let baseIconURL: String = "http://openweathermap.org/img/wn/"

        init(iconID: String, type: IconType = .png) {
            icon += baseIconURL
            icon += iconID
            icon += "@2x."
            icon += type.rawValue
            //print(icon)
        }*/
        
    }
    
}
