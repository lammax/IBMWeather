//
//  MapSceneView.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI

struct MapSceneView: View {
    
    @ObservedObject var intent = MapSceneIntent()
    
    var body: some View {
        MapView(checkpoints: $intent.checkpoints, currentLocation: $intent.currentLocation)
    }
}

struct MapSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MapSceneView()
    }
}
