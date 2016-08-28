//
//  StorageManager.swift
//  FunBoxTest
//
//  Created by Алексей on 27.08.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import Foundation
import PromiseKit

protocol StorageManager {
    func exportToStorage() -> Promise<NSData>
    func importFromStorage(data: NSData) -> Promise<Void>
}

class JSONStorageManagerAdapter: StorageManager {
    var jsonStorageManager : JSONStorageManager
    
    func exportToStorage() -> Promise<NSData> {
        return jsonStorageManager.exportToData()
    }
    
    func importFromStorage(data: NSData) -> Promise<Void> {
        return jsonStorageManager.importFromData(data)
    }
    
    init (jsonDataManager: JSONStorageManager) {
        jsonStorageManager = jsonDataManager
    }
}