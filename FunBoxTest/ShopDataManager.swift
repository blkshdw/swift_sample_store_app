//
//  ShopDataManager.swift
//  FunBoxTest
//
//  Created by Алексей on 21.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

enum DataError: ErrorType {
    case NoItemsLeft
}

class ShopDataManager {
    static let instance = ShopDataManager()
    
    func buyItem(item: ShopItem) -> Promise<ShopItem> {
        return Promise {fullfill, reject in
            let realm = try! Realm()
            if item.amount > 0 {
                do {
                    try realm.write {
                        item.amount -= 1
                        try realm.commitWrite()
                    }
                } catch {
                    reject(error)
                }
                
                return fullfill(item)
            } else {
                reject(DataError.NoItemsLeft)
            }
        }
    }
    
    func editItem(item: ShopItem, @noescape closure: Void -> Void) -> Promise<ShopItem> {
        return Promise {fullfill, reject in
            let realm = try! Realm()
            try! realm.write {
                closure()
                try! realm.commitWrite()
            }
            return fullfill(item)
        }
    }
    
}