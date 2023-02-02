//
//  City&ContryFile.swift
//  AppleMapCityContry
//
//  Created by Guru Mahan on 25/01/23.
//

import Foundation
import MapKit

struct LandMark {
    let placeMark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placeMark.name ?? ""
    }
    
    var title: String {
        self.placeMark.title ?? ""
        
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placeMark.coordinate
    }
}


final class LandmarkAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
   
    init(landmark: LandMark) {
        
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}


