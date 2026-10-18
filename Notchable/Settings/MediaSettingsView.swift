//
//  MediaSettingsView.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import DynamicNotchKit
import SwiftUI

struct MediaSettingsView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        List {
            Button("Start") {}
            Button("Play Pause") {
                Task {
                    await mediaController?.playPause()
                }
            }
            Button("Play") {
                Task {
                    await mediaController?.play()
                }
            }
            Button("Pause") {
                Task {
                    await mediaController?.pause()
                }
            }
            Section {
                NowPlayingNotchExpandedView()
            }
            Section {
                Button("expand") {
                    Task {
                        await NowPlayingNotch.expand()
                    }
                }
                Button("compact") {
                    Task {
                        await NowPlayingNotch.compact()
                    }
                }
                Button("hide") {
                    Task {
                        await NowPlayingNotch.hide()
                    }
                }
            }
        }
    }
}

#Preview {
    MediaSettingsView()
}
