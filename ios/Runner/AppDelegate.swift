import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = self.window.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel.init(name: "com.example/value", binaryMessenger: controller)
    
    channel.setMethodCallHandler{ (call, result) in
        if (call.method == "getValue"){
            result("Success - iOS")
        }else{
            result(FlutterMethodNotImplemented)
        }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
