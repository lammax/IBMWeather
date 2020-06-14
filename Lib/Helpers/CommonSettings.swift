//
//  CommonSettings.swift
//  IBMWeather
//
//  Created by Mac on 14.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Combine

class CommonSettings: ObservableObject {
    @Published var city: String = ""
    @Published var weatherItemsFirst4: [WeatherItem] = []
    @Published var weatherItemsHours: [WeatherItem] = []
    @Published var weatherItemsDays: [WeatherItem] = []
    @Published var showWeather: Bool = false
}
