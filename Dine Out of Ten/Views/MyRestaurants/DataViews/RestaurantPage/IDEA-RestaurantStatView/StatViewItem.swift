//
//  StatView.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 1/23/21.
//

import SwiftUI

struct StatViewItem: View {
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
                    Text("#").baselineOffset(6).font(.system(size: 24))
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
            .subheadline
        }
        var mainFont: Font {
            switch type {
            case .BestOrder, .WorstOrder:
                return .title3
            case .LoggedOrders:
                return .title
            case .RestaurantRank:
                return .system(size: 30)
            }
        }
        var bottomFont: Font {
            .subheadline
        }
    
    var body: some View {
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
        .padding(.horizontal)
    }
}

extension StatViewItem {
    enum WidgetType: String {
        case BestOrder = "BEST ORDER"
        case WorstOrder = "WORST ORDER"
        case LoggedOrders = "ORDERS"
        case RestaurantRank = "RANK"
    }
}

//struct StatViewItem_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantPage(restaurant: userRestaurants[0])
//    }
//}
