//
//  ContentView.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import FirebasePerformance

struct ContentView: View {
    
    func makeMultipleTrackedNetworkCalls() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let request = URLRequest(url: url)
        for i in 1...5 {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request \(i) Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse {
                    print("Request \(i) Response status code: \(response.statusCode)")
                }
            }
            .resume()
        }
    }
    
    func simulateBackgroundTask() {
        makeMultipleTrackedNetworkCalls()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            print("Simulating app suspension")
        }
    }

    
    
    var body: some View {
            VStack(spacing: 20) {
                
                
                Button("Multiple calls") {
                    makeMultipleTrackedNetworkCalls()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Simulate BG Tasks"){
                    simulateBackgroundTask()
                }
                
                
                Button("Crash App") {
                    fatalError("This is a test crash")
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
}

#Preview {
    ContentView()
}




