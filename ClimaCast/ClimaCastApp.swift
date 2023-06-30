//
//  ClimaCastApp.swift
//  ClimaCast
//
//  Created by Saee Saadat on 6/15/23.
//

import SwiftUI

@main
struct ClimaCastApp: App {

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            ContentView()
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

