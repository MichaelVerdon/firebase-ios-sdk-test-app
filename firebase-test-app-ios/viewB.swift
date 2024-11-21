//
//  viewB.swift
//  firebase-test-app-ios
//
//  Created by Michael Verdon on 20/11/2024.
//

import SwiftUI
import FirebasePerformance

struct viewB: View {
    
    var body: some View {
            VStack(spacing: 20) {
                
                
                Text("View B")
                    .padding()
                    .font(.system(size: 50))
                
                Button("Crash App") {
                    fatalError("This is a test crash")
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
}

#Preview {
    viewB()
}
