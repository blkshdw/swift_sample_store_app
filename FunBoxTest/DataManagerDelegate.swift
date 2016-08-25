//
//  DataManagerDelegate.swift
//  FunBoxTest
//
//  Created by Алексей on 17.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func removeItemAtIndex(index: Int)
    func appendItem(item: ShopItem)
    func fetchItems()
    func fetchItemAtIndex(index: Int)
}