//
//  ContentView.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import FirebasePerformance

struct ContentView: View {
    
    func makeTrackedNetworkCall() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // ✅ Network call using dataTask, which is tracked by Firebase Performance Monitoring.
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let response = response as? HTTPURLResponse {
                print("Tracked Response status code: \(response.statusCode)")
            }
        }
        .resume()
        
    }
    
    func makeUntrackedNetworkCall() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            // ❌ Network call using `URLSession.shared.data(for:)`, not tracked by Firebase Performance Monitoring.
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("Untracked Response status code: \(httpResponse.statusCode)")
            }
            print("Data size: \(data.count) bytes")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    @State private var welcomeMessage: String = remoteConfig["welcome_message"].stringValue ?? "Loading..."
        @State private var featureEnabled: Bool = remoteConfig["feature_enabled"].boolValue
    
    var body: some View {
            VStack(spacing: 20) {
                Text(welcomeMessage)
                    .font(.headline)
                
                if featureEnabled {
                    Text("Feature is enabled!")
                        .foregroundColor(.green)
                } else {
                    Text("Feature is disabled.")
                        .foregroundColor(.red)
                }
                
                Button("Tracked Network Call") {
                    makeTrackedNetworkCall()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Untracked Network Call") {
                    Task {
                        await makeUntrackedNetworkCall()
                    }
                }
                .buttonStyle(.bordered)
                
                Button("Crash App") {
                    fatalError("This is a test crash")
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .onAppear {
                // Update state on appearance if necessary
                welcomeMessage = remoteConfig["welcome_message"].stringValue ?? "Welcome!"
                featureEnabled = remoteConfig["feature_enabled"].boolValue
            }
        }
}

#Preview {
    ContentView()
}




