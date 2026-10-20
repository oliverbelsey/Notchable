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
                NowPlayingNotchExpandedView(musicData: MusicData())
            }
            Section {
                Button("expand") {
                    Task {
                        await Notches.nowPlaying.expand()
                    }
                }
                Button("compact") {
                    Task {
                        await Notches.nowPlaying.compact()
                    }
                }
                Button("hide") {
                    Task {
                        await Notches.nowPlaying.hide()
                    }
                }
            }
        }
    }
}

#Preview {
    MediaSettingsView()
}
