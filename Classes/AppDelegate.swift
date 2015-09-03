//
//  AppDelegate.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Create an instance of the model object
        let model = Model()
        
        // Get a reference to the navigation controller
        let nav = window!.rootViewController as UINavigationController
        
        // Get a reference to the actual view controller
        let tvc = nav.topViewController as Launch
        
        // Pass the model object to the controller
        tvc.model = model
        
        return true
    }

}

