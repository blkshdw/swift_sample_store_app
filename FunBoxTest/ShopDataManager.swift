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

let OBJECT_CHANGED = "objectChanged"

enum DataError: ErrorType {
    case NoItemsLeft
    case InvalidJSONData
    case Unknown(error: String)
}

class ShopDataManager {
    static let instance = ShopDataManager()
    
    func buyItem(item: ShopItem) -> Promise<ShopItem> {
        return Promise {fullfill, reject in
            if item.amount > 0 {
                editItem(item) {
                    item.amount -= 1
                }.then { item in
                    fullfill(item)
                }
            } else {
                reject(DataError.NoItemsLeft)
            }
        }
    }
    
    func editItem(item: ShopItem, @noescape closure: Void -> Void) -> Promise<ShopItem> {
        return Promise {fullfill, reject in
            let realm = try! Realm()
            do {
                try realm.write {
                    closure()
                }
            } catch {
                reject(error)
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(OBJECT_CHANGED, object: item.id)
            
            return fullfill(item)
        }
    }
    
}