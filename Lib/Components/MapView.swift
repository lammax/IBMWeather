//
//  MapView.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var settings: CommonSettings
    
    @Binding var checkpoints: [WeatherpointAnnotation]
    @Binding var currentLocation: CLLocationCoordinate2D?
    
    @State private var mapView: MKMapView = MKMapView(frame: UIScreen.main.bounds)
  
    func makeUIView(context: Context) -> MKMapView {
        mapView.isUserInteractionEnabled = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(checkpoints)
        if let currentCoordinate = currentLocation, let checkPoint = checkpoints.last, checkPoint.coordinate ==  currentCoordinate {
            centerViewOnUserLocation(uiView, location: checkPoint.coordinate)
        }
    }
    
    func centerViewOnUserLocation(_ uiView: MKMapView, location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: location, span: uiView.region.span)
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
            self.registerMapAnnotationViews()
        }
        
        func setupGestures() {
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
            parent.mapView.addGestureRecognizer(gestureRecognizer)
        }
        @objc func handleLongTap(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                let locationInView = sender.location(in: parent.mapView)
                let locationOnMap = parent.mapView.convert(locationInView, toCoordinateFrom: parent.mapView)
                self.parent.currentLocation = locationOnMap
            }
        }
        
        private func registerMapAnnotationViews() {
            parent.mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(WeatherpointAnnotation.self))
        }
        
        private func setupWeatherpointAnnotation(for annotation: WeatherpointAnnotation, on mapView: MKMapView) -> MKAnnotationView {
            let reuseIdentifier = NSStringFromClass(WeatherpointAnnotation.self)
            let weatherAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
            
            weatherAnnotationView.canShowCallout = true
            
            // Provide the annotation view's image.
            let image: UIImage = annotation.image.resizedImage(for: CGSize(width: 40, height: 40))
            weatherAnnotationView.image = image
            
            // Provide the left image icon for the annotation.
            weatherAnnotationView.leftCalloutAccessoryView = UIImageView(image: image)
            
            let rightButton = UIButton(type: .detailDisclosure)
            weatherAnnotationView.rightCalloutAccessoryView = rightButton
            
            // Offset the flag annotation so that the flag pole rests on the map coordinate.
            let offset = CGPoint(x: 0.0, y: -(image.size.height / 2) )
            weatherAnnotationView.centerOffset = offset
            
            return weatherAnnotationView
        }

        //MARK: Delegate
        
        /// Called whent he user taps the disclosure button in the bridge callout.
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // This illustrates how to detect which annotation type was tapped on for its callout.
            if let annotation = view.annotation, annotation.isKind(of: WeatherpointAnnotation.self) {
                self.parent.settings.showWeather = true
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            guard !annotation.isKind(of: MKUserLocation.self) else {
                // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
                return nil
            }
            
            var annotationView: MKAnnotationView?
            
            if let annotation = annotation as? WeatherpointAnnotation {
                annotationView = setupWeatherpointAnnotation(for: annotation, on: mapView)
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print(view.self)
        }
        
    }
    
}
