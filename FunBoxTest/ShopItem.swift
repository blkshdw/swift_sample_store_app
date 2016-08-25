//
//  ShopItem.swift
//  FunBoxTest
//
//  Created by Алексей on 17.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import RealmSwift

class ShopItem: Object {
    dynamic var title: String = ""
    dynamic var amount: Int = 0
    dynamic var price: Double = 0
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    enum keyPaths : String {
        case Title = "title"
        case Amount = "amount"
        case Price = "price"
    }
    
    var amountString: String {
        return String(amount)
    }
    
    var priceString: String {
        return String(price)
    }
    
    var displayAmount: String {
        return amountString + " items"
    }
    
    var displayPrice: String {
        return priceString + " $"
    }
    
}
