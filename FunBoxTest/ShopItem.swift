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
    dynamic var id: String  = NSUUID().UUIDString
    dynamic var title: String = ""
    dynamic var amount: Int = 0
    dynamic var price: Double = 0
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    override static func primaryKey() -> String? {
        return "id"
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
