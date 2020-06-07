//
//  MapView.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    
    @Binding var checkpoints: [Checkpoint]
    
    @State private var mapView: MKMapView = MKMapView(frame: UIScreen.main.bounds)
  
    func makeUIView(context: Context) -> MKMapView {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if checkpoints.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(checkpoints)
            if let checkPoint = checkpoints.first {
                centerViewOnUserLocation(uiView, location: checkPoint.coordinate)
            }
        }
    }
    
    func centerViewOnUserLocation(_ uiView: MKMapView, location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000.0, longitudinalMeters: 10000.0)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.setupGestures()
        }
        
        func setupGestures() {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            parent.mapView.addGestureRecognizer(gestureRecognizer)
        }
        @objc func handleTap(sender: UITapGestureRecognizer) {
            let locationInView = sender.location(in: parent.mapView)
            let locationOnMap = parent.mapView.convert(locationInView, toCoordinateFrom: parent.mapView)
            let newCheckPoint = Checkpoint(title: "New checkpoint", coordinate: .init(latitude: locationOnMap.latitude, longitude: locationOnMap.longitude))
            DispatchQueue.main.async {
                self.parent.checkpoints += [newCheckPoint]
            }
        }


        
    }
    
}
