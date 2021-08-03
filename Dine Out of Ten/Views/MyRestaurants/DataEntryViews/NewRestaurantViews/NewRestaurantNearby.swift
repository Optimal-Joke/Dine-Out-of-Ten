//
//  NewRestaurantNearby.swift
//  NewRestaurantNearby
//
//  Created by Hunter Holland on 7/22/21.
//

import SwiftUI
import CoreLocation

struct NewRestaurantNearby: View {
    @EnvironmentObject var resultHandler: MapSearchResultDelegate
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if loadingState == .loading {
                LoadingIndicator()
                    .padding(.top)
                
                Text("Loading nearby places...")
                
            } else if loadingState == .loaded {
                MKSearchResultsListView(resultsService: resultHandler)
            
            } else if loadingState == .failed {
                FailedSearchBackground()

            }
            
            Spacer()
        }
        .navigationTitle(Text("Nearby"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.resultHandler.searchNearby()
        }
    }
    
    private var loadingState: LoadingState {
        if resultHandler.isSearching {
            return .loading
        } else if !resultHandler.isSearching && !resultHandler.places.isEmpty {
            return .loaded
        } else {
            return .failed
        }
    }
    
    enum LoadingState {
        case loading
        case loaded
        case failed
    }
}

//struct NewRestaurantNearby_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRestaurantNearby()
//    }
//}
