import UIKit
import Flutter

import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
    
      application.registerForRemoteNotifications()
      GeneratedPluginRegistrant.register(with: self)
   
//    application.applicationIconBadgeNumber = 0//add this before the code below
    
   
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

 
    override func application(_ application: UIApplication, didReceiveRemoteNotification
       userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("APN recieved")
        // print(userInfo)

        let state = application.applicationState
        switch state {

        case .inactive:
            print("Inactive")

        case .background:
            print("Background")
            // update badge count here
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1

        case .active:
            print("Active")

        @unknown default:
            print("Error")

        }
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        // reset badge count
        application.applicationIconBadgeNumber = 0
    }
}
