//
//  MapSceneView.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI

struct MapSceneView: View {
    
    @EnvironmentObject var settings: CommonSettings
    
    @ObservedObject var intent = MapSceneIntent()
    
    var body: some View {
        MapView(checkpoints: $intent.checkpoints, currentLocation: $intent.currentLocation)
        .environmentObject(self.settings)
        .sheet(isPresented: self.$settings.showWeather) {
            WeatherSceneView()
            .onDisappear {
                    self.settings.showWeather = false
            }
            .environmentObject(self.settings)
        }
        .onAppear {
            self.intent.setup(settings: self.settings)
        }
    }
    
}

struct MapSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MapSceneView()
    }
}
