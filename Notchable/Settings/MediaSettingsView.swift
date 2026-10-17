//
//  MediaSettingsView.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import DynamicNotchKit
import SwiftUI

struct MediaSettingsView: View {
    var body: some View {
        List {
            Button("Start") {}
            Button("Play Pause") {
                sendMediaCommand(.playPause)
            }
            Button("Play") {
                sendMediaCommand(.play)
            }
            Button("Pause") {
                sendMediaCommand(.pause)
            }
            Section {
                NowPlayingNotchExpandedView(musicData: musicData)
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
