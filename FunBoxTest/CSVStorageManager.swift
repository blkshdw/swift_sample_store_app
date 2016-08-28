//
//  CSVDataManager.swift
//  FunBoxTest
//
//  Created by Алексей on 17.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import CSwiftV
import RealmSwift

class CSVDataManager {
    
    static let headers = ["title", "price", "amount" ]
    static let separator = ","
    
    static func loadTestDataIfNeeded() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if !defaults.boolForKey("didLoadTestData") {
            if let fileURL = NSBundle.mainBundle().URLForResource("data", withExtension:"csv") {
                if let data = NSData(contentsOfURL: fileURL) {
                    if let content = String(data: data, encoding: NSUTF8StringEncoding) {
                        if let data = CSwiftV(string: content, separator: ",", headers: headers).keyedRows {
                            for var item in data {
                                let shopItem = ShopItem()
                                shopItem.title = item["title"] ?? ""
                                shopItem.amount = Int(item["amount"] ?? "") ?? 0
                                shopItem.price = Double(item["price"] ?? "") ?? 0.0
                                
                                try! uiRealm.write {
                                    uiRealm.add(shopItem)
                                }

                            }
                            
                            defaults.setBool(true, forKey: "didLoadTestData")
                            return
                        }
                    }
                }
            }
            
            
        }
    }
        
}