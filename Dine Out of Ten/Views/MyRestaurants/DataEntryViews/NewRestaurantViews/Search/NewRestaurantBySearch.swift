//
//  NewRestaurantView.swift
//  NewRestaurantView
//
//  Created by Hunter Holland on 12/25/20.
//

import SwiftUI
import CoreLocation

struct NewRestaurantBySearch: View {
    
    @StateObject var resultHandler = MapSearchResultDelegate()
    
    @State var locationManager = CLLocationManager()
            
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $resultHandler.searchQuery)
                
                switch loadingState {
                case .idle:
                    IdleSearchBackground()
                        .padding(.top)
                case .loading:
                    LoadingIndicator()
                        .padding(.top)
                case .loaded:
                    MKSearchResultsListView(resultsService: resultHandler)
                case .failed:
                    FailedSearchBackground()
                        .padding(.top)
                }
                
                Spacer()
            }
            .onAppear(perform: {
                locationManager.delegate = resultHandler
                locationManager.requestAlwaysAuthorization()
            })
            .onChange(of: resultHandler.searchQuery) { value in
                let delay = 0.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    if value == resultHandler.searchQuery {
                        self.resultHandler.searchWithCurrentQuery()
                    }
                }
            }
            .navigationTitle(Text("Restaurant Search"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() },
                           label:  { Text("Cancel") }
                    )
                }
            }
            .alert(isPresented: $resultHandler.permissionDenied) {
                Alert(
                    title: Text("Cannot Determine Location"),
                    message: Text("You haven't allowed Dine Out of Ten to use your location! You can change this in Settings."),
                    primaryButton: .default(Text("Settings"), action: {
                        // Redirecting to user settings
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        
//                        locationManager.requestWhenInUseAuthorization()
                    }),
                    secondaryButton: .cancel(Text("Later"))
                )
            }
        }
        .environmentObject(resultHandler)
    }
    
    private var loadingState: LoadingState {
        if resultHandler.searchQuery == "" {
            return .idle
        } else if resultHandler.isSearching {
            return .loading
        } else if !resultHandler.isSearching && !resultHandler.places.isEmpty {
            return .loaded
        } else {
            return .failed
        }
    }
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case failed
    }
}

// MARK: - Preview
struct NewRestaurantBySearch_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantBySearch()
    }
}
