//
//  JSONStorageManager.swift
//  FunBoxTest
//
//  Created by Алексей on 27.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import PromiseKit
import RealmSwift
import SwiftyJSON

class JSONStorageManager {
    
    func exportToData() -> Promise<NSData> {
        return Promise {fullfill, reject in
            let realm = try! Realm()
            let shopItems = realm.objects(ShopItem)
            
            var itemsArray: [JSON] = []
            
            for shopItem in shopItems {
                var json:JSON = [:]
                json["id"].string = shopItem.id
                json["name"].string = shopItem.title
                json["amount"].int = shopItem.amount
                json["price"].double = shopItem.price
                itemsArray.append(json)
            }
            
            let jsonArray = JSON(itemsArray)
            
            
            do {
                try fullfill(jsonArray.rawData())
            } catch {
                reject(error)
            }
        }
    }
    
    func importFromData(data: NSData) -> Promise<Void> {
        return Promise { fullfill, reject in
            let realm = try! Realm()
            let jsonItems = JSON(data: data)
            if let items = jsonItems.array {
                for item in items {
                    let newItem : ShopItem
                    
                    realm.beginWrite()
                    
                    if let itemToUpdate = realm.objectForPrimaryKey(ShopItem.self, key: item["id"].string) {
                        newItem = itemToUpdate
                    } else {
                        newItem = ShopItem()
                        newItem.id = item["id"].string ?? newItem.id
                    }
                    newItem.title = item["title"].string ?? newItem.title
                    newItem.amount = item["amount"].int ?? newItem.amount
                    newItem.price = item["price"].double ?? newItem.price
                    
                    do {
                        try realm.commitWrite()
                    } catch {
                        reject(error)
                    }
                }
                fullfill()
            } else {
                reject(DataError.InvalidJSONData)
            }
            
        }

    }
}