//
//  ContentView.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 13/11/2024.
//

import SwiftUI
import UIKit
import FirebasePerformance

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                
                NavigationLink( destination: viewA()) {
                    Text("View A")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink( destination: viewB()) {
                    Text("View B")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Crash App") {
                    fatalError("This is a test crash")
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}




