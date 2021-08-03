//
//  SearchBackgroundPlaceholders.swift
//  SearchBackgroundPlaceholders
//
//  Created by Hunter Holland on 8/2/21.
//

import SwiftUI

// MARK: IdleSearchBackground
struct IdleSearchBackground: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "magnifyingglass")
                .font(.custom("SF Mono", size: 70))
                .foregroundColor(.secondary)
                .padding(.bottom)
                .shadow(color: .primary, radius: 9, x: 0, y: 15)
            
            Text("Type the name of the restaurant you're looking for...")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(minHeight: 60)
            
            Text("or")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
                .padding(.bottom, 8)
            
            AlternateSearchOptionButtons()
        }
        .frame(width: 300)
    }
}

// MARK: - FailedSearchBackground
struct FailedSearchBackground: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.arrow.circlepath")
                .font(.custom("SF Mono", size: 70))
                .foregroundColor(.red)
                .padding(.bottom)
                .shadow(color: .primary, radius: 13, x: 0, y: 15)
            
            Text("Uh oh! Your search didn't turn up any results.")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(minHeight: 60)
            
            Text("Try changing your search, or")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
                .padding(.bottom, 8)
            
            AlternateSearchOptionButtons()
        }
        .frame(width: 300)
    }
}

// MARK: - AlternateSearchOptionButtons
struct AlternateSearchOptionButtons: View {
    var body: some View {
        VStack {
            // ADD SUPPORT FOR NEARBY LOCATION FINDING
            //            NavigationLink(destination: NewRestaurantNearby()) {
            //                Text("Search around your location")
            //                    .padding([.vertical, .horizontal], 10)
            //                    .background(Color(UIColor.systemGray5))
            //                    .clipShape(RoundedRectangle(cornerRadius: 15))
            //            }
            //
            //            Text("or")
            //                .fontWeight(.medium)
            //                .multilineTextAlignment(.center)
            //                .padding([.top, .bottom], 4)
            
            NavigationLink(destination: NewRestaurantInfoView()) {
                Text("Add restaurant manually")
                    .padding([.vertical, .horizontal], 10)
                    .background(Color(UIColor.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

struct SearchBackgroundPlaceholders_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            IdleSearchBackground()
            FailedSearchBackground()
        }
    }
}
