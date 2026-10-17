//
//  SettingsView.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear") {
                GeneralSettingsView()
            }
            Tab("Music", systemImage: "music.note") {
                MediaSettingsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization(nil)
    }
}

#Preview {
    SettingsView()
}
