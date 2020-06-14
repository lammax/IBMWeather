//
//  Common.swift
//  IBMWeather
//
//  Created by Mac on 13.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

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

enum DayOfWeek: String, Decodable {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thursday = "Четверг"
    case friday = "Пятница"
    case saturday = "Суббота"
    case sunday = "Воскресенье"
}

enum DayOrNight: String, Decodable {
    case day = "D"
    case night = "N"
}

enum PrecipType: String, Decodable {
    case rain
    case snow
    case precip
}
