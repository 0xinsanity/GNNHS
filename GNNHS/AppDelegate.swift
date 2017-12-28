//
//  AppDelegate.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit
import AudioToolbox
import Fabric
import Crashlytics
import Parse
import ParseFacebookUtilsV4
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //var layerClient: LYRClient?
    //let LayerAppIDString: NSURL! = NSURL(string: "layer:///apps/staging/8f8fd8c6-c517-11e5-87e2-80b60f00199c")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        //setupLayer()
        //self.registerApplicationForPushNotifications(application)
        
        let main_tab = MainTabBar()
        
        let school_info = SchoolInfoController()
        school_info.tabBarItem = UITabBarItem(title: "School Info", image: UIImage(named: "tabBarIcons_school_info_selected"), selectedImage: nil)
        
        let clubs_messaging = ClubsMessagingController()
        clubs_messaging.tabBarItem = UITabBarItem(title: "Club Messaging", image: UIImage(named: "tabBarIcons_chat_messaging"), selectedImage: nil)
        let navigationController = UINavigationController(rootViewController: clubs_messaging)
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Expressway", size: 19)!]
        
        navigationController.navigationBar.barTintColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        
        let contact_teacher = ContactTeachersController()
        contact_teacher.tabBarItem = UITabBarItem(title: "Teachers", image: UIImage(named: "tabBarIcons_contacts"), selectedImage: nil)
        //<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
        
        let nearby_restaurants = NearbyRestaurants()
        nearby_restaurants.tabBarItem = UITabBarItem(title: "Lunch", image: UIImage(named: "tabBarIcons_restaurants"), selectedImage: nil)
        // <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
        
        let resources_tab = ResourcesController()
        resources_tab.tabBarItem = UITabBarItem(title: "Websites", image: UIImage(named: "tabBarIcons_websites"), selectedImage: nil)
        //<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
        
        main_tab.viewControllers = [school_info, navigationController, contact_teacher, nearby_restaurants, resources_tab]
        main_tab.tabBar.barTintColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        main_tab.tabBar.tintColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
        
        let rootViewController = UINavigationController(rootViewController: main_tab)
        
        window?.rootViewController = rootViewController
        
        rootViewController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Expressway", size: 19)!]
        
        rootViewController.navigationBar.barTintColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        Fabric.with([Crashlytics.self])
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "5LA5kojEziCljqw4vZ9iZGNRQXwaOJG0jmcQaLYY"
            $0.clientKey = "3blkIu9VUcQxLSVrlbXBHldpW6j8oPHF0ZZ5ebdZ"
            $0.server = "https://still-ocean-70241.herokuapp.com/parse"
            //$0.server = "https://parsetest.ngrok.io/parse"
        }
        Parse.initialize(with: configuration)
        
        PFAnalytics.trackAppOpened(launchOptions: launchOptions)
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
        
        let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                handleShortcutItem(shortcutItem)
            }
        } else {
            // Fallback on earlier versions
        }
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let installation = PFInstallation.current()
        if (installation.badge != 0) {
            installation.badge = 0
            installation.saveEventually()
        }
        FBSDKAppEvents.activateApp()
    }

    /*func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if (application.applicationState == UIApplicationState.active) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            let rootViewController = self.window?.rootViewController?.childViewControllers.last as! UITabBarController
            let tabArray = rootViewController.tabBar.items as NSArray!
            let tabItem = tabArray?.object(at: 1) as! UITabBarItem
            if (tabItem.badgeValue == nil) {
                tabItem.badgeValue = "1"
            } else {
                let newNumber = (Int(tabItem.badgeValue!)! + 1)
                tabItem.badgeValue = String(newNumber)
            }
            UIApplication.shared.applicationIconBadgeNumber = Int(tabItem.badgeValue!)!
        }
    }*/
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation.setDeviceTokenFrom(deviceToken)
        installation.saveInBackground()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handle(userInfo)
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier.rawValue == "com.apple.keyboard-service") {
            return false
        }
        return true
    }

    @available(iOS 9.0, *)
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) {
        switch shortcutItem.type {
        case "net.hanovernoah.schedule_ordinary":
                (window?.rootViewController?.childViewControllers.last as! UITabBarController).selectedIndex = 0
                break;
            case "net.hanovernoah.lunch":
                (window?.rootViewController?.childViewControllers.last as! UITabBarController).selectedIndex = 3
                break;
            case "net.hanovernoah.websites":
                (window?.rootViewController?.childViewControllers.last as! UITabBarController).selectedIndex = 4
                break;
            case "net.hanovernoah.your_clubs":
                (window?.rootViewController?.childViewControllers.last as! UITabBarController).selectedIndex = 1
                break;
            default:
                break;
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleShortcutItem(shortcutItem)
    }
    
}

