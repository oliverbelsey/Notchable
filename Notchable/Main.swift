//
//  Main.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI

@main
struct NotchableApp: App {
    @Environment(\.openWindow) var openWindow

    var body: some Scene {
        MenuBarExtra("Notchable", systemImage: "inset.filled.topthird.rectangle") {
            Button("Settings") {
                openWindow(id: "settings")
            }
            .keyboardShortcut(KeyEquivalent(","), modifiers: .command)
            Divider()
            Button("Quit", role: .destructive) {
                NSApp.terminate(nil)
            }
            .keyboardShortcut(KeyEquivalent("q"), modifiers: .command)
        }
        Window("Settings", id: "settings") {
            SettingsView()
        }

        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("Settings") {
                    openWindow(id: "settings")
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }
    }
}
