import SwiftUI

struct SettingsView: View {

    @AppStorage("isCelsius") private var isCelsius = true
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Temperature Unit")) {
                    Toggle(isOn: $isCelsius) {
                        Text("Celsius")
                    }
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}