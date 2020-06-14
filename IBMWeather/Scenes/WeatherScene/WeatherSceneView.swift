//
//  WeatherSceneView.swift
//  IBMWeather
//
//  Created by Mac on 14.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

import SwiftUI

struct WeatherSceneView: View {
    
    @EnvironmentObject var settings: CommonSettings
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var intent = WeatherSceneIntent()
    
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 2)
            .frame(width: 40, height: 4)
            .foregroundColor(textColor)
            .padding()
            
            Text(settings.city)
            
            List(settings.weatherItemsFirst4 + settings.weatherItemsHours + settings.weatherItemsDays) { item in
                WeatherRow(item: item)
            }

        }
    }
    
    var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
}

struct WeatherSceneView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSceneView()
    }
}

struct WeatherRow: View {
    var item: WeatherItem

    var body: some View {
        HStack {
            Text(item.date)
            item.icon
            Text(item.temp)
            Text(item.wind)
            Text(item.humidity)
        }
    }
}
