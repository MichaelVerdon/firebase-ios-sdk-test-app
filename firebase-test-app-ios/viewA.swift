import SwiftUI
import FirebasePerformance
import FirebaseAnalytics

struct viewA: View {
    private var trace: Trace?

    init() {
        trace = Performance.startTrace(name: "viewA_render_time")
    }
    
    func doNetworkStuff(){
        // Shortened for example.
        print("Network stuff")
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("View A")
                .padding()
                .font(.system(size: 50))

            Button("Crash App") {
                fatalError("This is a test crash")
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            print("viewA appeared")
            // Do network stuff
            doNetworkStuff()

            // Log an event to Firebase (manual screen tracking)
            // In Documentation
            Analytics.logEvent("viewA_appeared", parameters: [
                "screen_name": "View A",
                "timestamp": Date().timeIntervalSince1970
            ])

            // Stop the trace when the last operation to complete
            // has completed, assuming it is the network operation which is likely
            trace?.stop()
            print("Trace for viewA stopped")
        }
    }
}

#Preview {
    viewA()
}

