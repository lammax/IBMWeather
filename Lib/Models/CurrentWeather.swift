//
//  CurrentWeather.swift
//  IBMWeather
//
//  Created by Mac on 09.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

/*
 //Example
{
   "metadata":{
      "language":"en-US",
      "transaction_id":"1591647858217:-730444882",
      "version":"1",
      "latitude":56.86,
      "longitude":35.89,
      "units":"m",
      "expire_time_gmt":1591648458,
      "status_code":200
   },
   "forecast":{
      "class":"fod_short_range_nowcast",
      "expire_time_gmt":1591648458,
      "fcst_valid":1591646400,
      "fcst_valid_local":"2020-06-08T23:00:00+0300",
      "icon_code":29,
      "qpf":0.0,
      "peak_wind":9,
      "peak_severity":1,
      "narrative_512char":"Partly cloudy. Temperatures steady 18 to 20C. Winds light and variable.",
      "narrative_256char":"Partly cloudy. Temperatures steady 18 to 20C. Winds light and variable.",
      "narrative_128char":"Partly cloudy. Winds light and variable.",
      "narrative_32char":"Partly cloudy."
   }
}
*/

struct CurrentWeather: Decodable {
    let metadata: Metadata?
    let forecast: Forecast?
    
    init(metadata: Metadata? = nil, forecast: Forecast? = nil) {
        self.metadata = metadata
        self.forecast = forecast
    }
    
    static var placeholder: CurrentWeather {
        CurrentWeather(metadata: nil, forecast: nil)
    }
}

struct Metadata: Decodable {
    let language: Constants.Lang?
    let transaction_id: String?
    let version: String?
    let latitude: Double?
    let longitude: Double?
    let units: Constants.Units?
    let expire_time_gmt: UInt?
    let status_code: Int?
}

struct Forecast: Decodable {
    let classs: String?
    let expire_time_gmt: UInt?
    let fcst_valid: UInt
    let fcst_valid_local: String?
    let icon_code: Int?
    let qpf: Float?
    let peak_wind: Int?
    let peak_severity: Int
    let narrative_512char: String?
    let narrative_256char: String?
    let narrative_128char: String?
    let narrative_32char: String?
    
    enum CodingKeys: String, CodingKey {
        case classs = "class"
        case expire_time_gmt
        case fcst_valid
        case fcst_valid_local
        case icon_code
        case qpf
        case peak_wind
        case peak_severity
        case narrative_512char
        case narrative_256char
        case narrative_128char
        case narrative_32char
    }
}
