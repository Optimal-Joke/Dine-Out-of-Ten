//
//  MKSearchResultsListView.swift
//  MKSearchResultsListView
//
//  Created by Hunter Holland on 7/23/21.
//

import SwiftUI
import MapKit

struct MKSearchResultsListView: View {
    var resultsService: MapSearchResultDelegate
    
    var body: some View {
        List(resultsService.places) { place in
            NavigationLink(destination: NewRestaurantInfoView(using: place)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(place.name ?? "No name")
                            .padding(.top, padding)
                        Text(place.placemark.title ?? "No address")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .padding(.bottom, padding)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // show restaurant detail page
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                        .buttonStyle(BorderlessButtonStyle())
                        .foregroundColor(Color.secondary)
                }
                .contentShape(Rectangle())
            }
        }
        .listStyle(PlainListStyle())
    }
    
    let padding: CGFloat? = 4
}
