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
//                HStack{
//                    EmptyView()
//                }.frame(width: UIScreen.main.bounds.width,height: 20)
//                    .background(Color.gray)
//                    .gesture(TapGesture()
//                        .onEnded(self.onTap)
//                    )
                List {
                    ForEach(self.landmarks, id: \.id) { landmark in
                        VStack(alignment: .leading){
                            Text(landmark.name)
                                .fontWeight(.bold)
                            
                            Text(landmark.title)
                            
                        }
                        
                        
                    }
                }
                
            }}
    }
}

//struct PlaceListView_Previews: PreviewProvider {
//    static var previews: some View {
//    //    PlaceListView(landmarks: [LandMark(placeMark: MKPlacemark())], onTap: {})
//    }
//}
