//
//  ContentView.swift
//  ClimaCast
//
//  Created by Saee Saadat on 6/15/23.
//

// url: https://api.weatherapi.com/v1/search.json?key=c582e3515da44ce1a90113153220803

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
