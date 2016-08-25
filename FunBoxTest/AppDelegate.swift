//
//  AppDelegate.swift
//  FunBoxTest
//
//  Created by Алексей on 25.07.16.
//  Copyright © 2016 Алексей. All rights reserved.
//

import UIKit
import RealmSwift

let uiRealm = try! Realm()

let storyboard = UIStoryboard(name: "Main", bundle: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        CSVDataManager.loadTestDataIfNeeded()
        return true
    }
    
}

