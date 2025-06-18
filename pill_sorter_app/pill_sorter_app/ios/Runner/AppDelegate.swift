import UIKit
import Flutter
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    print("app delegate is running");
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    print("setPluginRestraint call back is done");

    GeneratedPluginRegistrant.register(with: self)
    print("with self is done");

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      print("notifs is done");
    }

    
    print("app delegate is done");
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

