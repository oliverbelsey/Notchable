//
//  GeneralSettings.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import SwiftUI

struct GeneralSettingsView: View {
    @State private var isOn = false
    var body: some View {
        List {
            Toggle(isOn: $isOn) {
                Text("Test")
                Text("Test description")
            }
            .toggleStyle(.switch)
            
        }
    }
}

#Preview {
    GeneralSettingsView()
}
