//
//  AppDelegate.swift
//  Spike
//
//  Created by Marta Tarragó on 20/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

var reachability: Reachability? // Can be nil or have a valure
var reachabilityStatus = WIFI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetCheck: Reachability?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Uable NSURL caching
        //NSURLCache.setSharedURLCache(NSURLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil));
        
        // Add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityCanged:", name: kReachabilityChangedNotification, object: nil)

        // Listen to any changes of internet or connectivity
        internetCheck = Reachability.reachabilityForInternetConnection()
        internetCheck?.startNotifier() // run loop
        
        return true
    }
    
    func reachabilityChanged(notification: NSNotification)
    {
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
    }
    
    func statusChangedWithReachability(currentReachabilityStatus: Reachability)
    {
        // Get the nwk status
        let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        
        // Updat our nwk status flag
        switch networkStatus.rawValue
        {
        case NotReachable.rawValue : reachabilityStatus = NOACCESS
        case ReachableViaWiFi.rawValue : reachabilityStatus = WIFI
        case ReachableViaWWAN.rawValue : reachabilityStatus = WWAN
        default: return
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Remove observer
        NSNotificationCenter.defaultCenter().removeObserver(self, name:kReachabilityChangedNotification, object: nil)
        
    }


}

