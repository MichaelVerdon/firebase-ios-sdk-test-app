import SwiftUI
import FirebaseRemoteConfig

struct ContentView: View {
    private var remoteConfig: RemoteConfig? {
        AppDelegate.shared.remoteConfig
    }

    @State private var welcomeMessage: String = "Loading..."
    @State private var featureEnabled: Bool = false

    func makeTrackedNetworkCall() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("Untracked Response status code: \(httpResponse.statusCode)")
            }
            print("Data size: \(data.count) bytes")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

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
            // Safely update state
            if let remoteConfig = remoteConfig {
                welcomeMessage = remoteConfig["welcome_message"].stringValue ?? "Welcome!"
                featureEnabled = remoteConfig["feature_enabled"].boolValue
            }
        }
    }
}

#Preview {
    ContentView()
}




