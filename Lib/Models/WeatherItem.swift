//
//  WeatherItem.swift
//  IBMWeather
//
//  Created by Mac on 14.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI

struct WeatherItem: Identifiable {
    var id = UUID()
    var date: String
    var icon: Image
    var temp: String
    var wind: String //wind cardianl direction
    var humidity: String //humidity %
}
