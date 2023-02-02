//
//  MapView.swift
//  AppleMapCityContry
//
//  Created by Guru Mahan on 27/01/23.
//

import Foundation

import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
}


struct MapView: UIViewRepresentable {
    
    let landmarks: [LandMark]
    var coordinate : CLLocationCoordinate2D
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
//        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        return map
        
    }
    
    func makeCoordinator() -> Coordinator {
       Coordinator(self)
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<MapView>) {
        updateAnnotation(from: uiView)
    }
    
   private func updateAnnotation(from mapView: MKMapView) {
       if let mapview = mapView.annotations .last{
           mapView.removeAnnotation(mapview)
       }
     
       let annotation = self.landmarks.map(LandmarkAnnotation.init)
       if let annotation1 = annotation.last{
           mapView.addAnnotation(annotation1 )
       }
      
    
    }
}



// Address search api:   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2O8juXuiHSo0OcV1oBCWo0wGjx9tdvjQ&libraries=places&callback=initMap">

