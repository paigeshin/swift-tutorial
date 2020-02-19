//
//  AppDelegate.swift
//  Todoey
//
//  Created by Angela Yu on 16/11/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let defaultPath = Realm.Configuration.defaultConfiguration.fileURL!
//        do {
//            try FileManager.default.removeItem(at: defaultPath)
//        } catch {
//            print("Error happened")
//        }
        
        do {
            if let localAddress = Realm.Configuration.defaultConfiguration.fileURL {
                print(localAddress)
            }
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
    
}

