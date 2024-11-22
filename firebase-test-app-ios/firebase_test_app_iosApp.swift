//
//  firebase_test_app_iosApp.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import Firebase
import FirebasePerformance
import FirebaseCore
import FirebaseRemoteConfig
import Firebase

let remoteConfig = RemoteConfig.remoteConfig()

func setupRemoteConfig() {
    let remoteConfig = RemoteConfig.remoteConfig()
    let nonExistentPlist = "NonExistentFile"
    
    // Try loading a non-existent plist file
    if let filePath = Bundle.main.path(forResource: nonExistentPlist, ofType: "plist") {
        remoteConfig.setDefaults(fromPlist: filePath)
    } else {
        print("Missing RemoteConfig plist file: \(nonExistentPlist).plist")
    }
}

func fetchAndUseRemoteConfig() {
    let remoteConfig = RemoteConfig.remoteConfig()
    
    let key = "exampleKey"
    let key2 = "exampleKey2"
    let value = remoteConfig.configValue(forKey: key).numberValue
    let value2 = remoteConfig.configValue(forKey: key2).numberValue
    print("Value for \(key): \(value)")
    print("Value for \(key2): \(value2)")
}





class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        
        setupRemoteConfig()
        fetchAndUseRemoteConfig()
        
        return true
    }
    
    
    @main
    struct YourApp: App {
        // register app delegate for Firebase setup
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        
        var body: some Scene {
            WindowGroup {
                NavigationView {
                    ContentView()
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
