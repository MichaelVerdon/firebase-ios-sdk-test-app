//
//  ContentView.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import FirebasePerformance

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Click me"){
                
            }
            Button("Crash") {
              fatalError("Crash was triggered")
            }
        }
        .padding()
        Spacer()
        
    }
        
}

#Preview {
    ContentView()
}
