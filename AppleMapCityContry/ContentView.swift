//
//  ContentView.swift
//  AppleMapCityContry
//
//  Created by Guru Mahan on 25/01/23.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
    @ObservedObject var viewModel = LocationManager()
    @State var landmarks: [LandMark] = [LandMark]()
    
    @State var search: String = ""
    @State var tapped: Bool = false
    @State var showPlaceView = false
    private func getNearBYlandMarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                
                self.landmarks = mapItems.map{
                    LandMark(placeMark: $0.placemark)
                }
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count>0 && !self.tapped{
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped{
            return 100
        }else{
            return UIScreen.main.bounds.size.height
        }

    }
   var coordinate : CLLocationCoordinate2D
    var body: some View {
        ZStack(alignment: .top) {
            MapView(landmarks: landmarks, coordinate: coordinate)
            TextField("Search", text: $search, onEditingChanged: {_ in}) {
                showPlaceView = true
                self.getNearBYlandMarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: 44)
        
          
        }
        .padding()
        .sheet(isPresented: $showPlaceView) {
            PlaceListView(landmarks: self.landmarks) {
                self.tapped.toggle()
            }.animation(.spring())
           //     .offset(y: calculateOffset())
        }
    }
    
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinate: CLLocationCoordinate2D())
    }
}
