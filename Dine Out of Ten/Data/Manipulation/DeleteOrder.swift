//
//  DeleteOrder.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation

extension MenuItem {
    func delete(order: Order) -> Order {
        self.orders.remove(at: self.orders.firstIndex { $0 == order }!)
    }
}
