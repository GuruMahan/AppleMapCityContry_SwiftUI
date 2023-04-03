//
//  PlaceListView.swift
//  AppleMapCityContry
//
//  Created by Guru Mahan on 27/01/23.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [LandMark]
    var onTap: () -> ()
    var body: some View {
        ZStack{
            VStack(alignment:.leading){
                List {
                    ForEach(self.landmarks, id: \.id) { landmark in
                        VStack(alignment: .leading){
                            Text(landmark.name)
                                .fontWeight(.bold)
                            Text(landmark.title)
                            
                        }
                    }
                }
            }
        }
    }
}
