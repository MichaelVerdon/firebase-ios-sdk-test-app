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

func setupDefaults() {
    let defaults: [String: NSObject] = [
        "welcome_message": "Welcome to the app!" as NSObject,
        "feature_enabled": false as NSObject
    ]
    remoteConfig.setDefaults(defaults)
}



class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        
        setupDefaults() // Set default values
        fetchRemoteConfigValues() // Fetch and activate Remote Config values
        
        return true
    }
    
    private func fetchRemoteConfigValues() {
        let fetchDuration: TimeInterval = 3600 // 1 hour
        remoteConfig.fetch(withExpirationDuration: fetchDuration) { status, error in
            if status == .success {
                print("Config fetched successfully!")
                remoteConfig.activate { _, _ in
                    print("Config activated successfully!")
                }
            } else {
                print("Config fetch failed: \(error?.localizedDescription ?? "No error available.")")
            }
        }
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
