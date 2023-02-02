//
//  AppleMapCityContryApp.swift
//  AppleMapCityContry
//
//  Created by Guru Mahan on 25/01/23.
//

import SwiftUI
import CoreLocation

@main
struct AppleMapCityContryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView( coordinate: CLLocationCoordinate2D())
        }
    }
}
