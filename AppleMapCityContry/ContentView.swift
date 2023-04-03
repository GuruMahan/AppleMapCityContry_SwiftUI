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
    var coordinate : CLLocationCoordinate2D
    
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
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(landmarks: landmarks, coordinate: coordinate)
            VStack {
                HStack(spacing: 0){
                    TextField("Search", text: $search, onEditingChanged: {_ in}) {
                        self.getNearBYlandMarks()
                    }
                    Button {
                        showPlaceView = true
                    } label: {
                        Text("Show")
                    }
                    .frame(width: 60,height: 33)
                    .background(Color.white)
                } .autocapitalization(.none)
                    .font(Font.custom("Roboto-Regular", size: 16))
                    .padding()
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(5)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.white))
            }.padding()
                .offset(y: 44)
        }
        .sheet(isPresented: $showPlaceView) {
            PlaceListView(landmarks: self.landmarks) {
                self.tapped.toggle()
            }.animation(.spring())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinate: CLLocationCoordinate2D())
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
