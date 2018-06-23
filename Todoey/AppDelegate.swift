//
//  AppDelegate.swift
//  Todoey
//
//  Created by Alejandro López Gómez on 3/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            _ = try Realm()
        } catch {
            print("Error on initializing realm \(error)")
        }
        return true
    }
}

