//
//  DashboardWidget.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 1/23/21.
//

import SwiftUI

struct DashboardWidget: View {
    var type: WidgetType
    var restaurant: Restaurant
    
    var topText: Text {
        Text(type.rawValue)
    }
    var mainText: Text {
        switch type {
        case .BestOrder:
            return Text("restaurant.highestRankedItem")
        case .WorstOrder:
            return Text("restaurant.lowestRankedItem")
        case .LoggedOrders:
            return Text("Int")
        case .RestaurantRank:
            var prettyRanking: Text {
                Text("#").baselineOffset(10).font(.system(size: 36))
                    + Text("3")
            }
            return prettyRanking
        }
    }
    var bottomText: Text? {
        switch type {
        case .BestOrder, .WorstOrder:
            return Text("Rating: Int")
        case .LoggedOrders:
            return Text("Int unique")
        case .RestaurantRank:
            return nil
        }
    }
    
    var topFont: Font {
        .footnote
    }
    var mainFont: Font {
        switch type {
        case .BestOrder, .WorstOrder:
            return .title3
        case .LoggedOrders:
            return .title
        case .RestaurantRank:
            return .system(size: 50)
        }
    }
    var bottomFont: Font {
        .subheadline
    }
    
    enum WidgetType: String {
        case BestOrder = "BEST ORDER"
        case WorstOrder = "WORST ORDER"
        case LoggedOrders = "LOGGED ORDERS"
        case RestaurantRank = "RESTAURANT RANK"
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.accentColor)
                .opacity(0.4)
            VStack {
                topText
                    .font(topFont)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Spacer()
                mainText
                    .font(mainFont)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Spacer()
                bottomText
                    .font(bottomFont)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

//struct DashboardWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantPage(restaurant: userRestaurants[0])
//    }
//}
