//
//  firebase_test_app_iosApp.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseRemoteConfig
import Firebase

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var remoteConfig: RemoteConfig?
    static let shared = AppDelegate()
    
    func applicationDidFinishLaunching(_ aNotification: Notification){
        FirebaseApp.configure()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        
        setupDefaults() // Set default values
        fetchRemoteConfigValues() // Fetch and activate Remote Config values
   
    }
    
    private func setupDefaults() {
        guard let remoteConfig = remoteConfig else { return }
        let defaults: [String: NSObject] = [
            "welcome_message": "Welcome to the app!" as NSObject,
            "feature_enabled": false as NSObject
        ]
        remoteConfig.setDefaults(defaults)
    }

    private func fetchRemoteConfigValues() {
        guard let remoteConfig = remoteConfig
        else { return }
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
}
    
    @main
    struct YourApp: App {
        // register app delegate for Firebase setup
        @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        
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
