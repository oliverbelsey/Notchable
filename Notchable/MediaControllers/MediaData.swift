//
//  MediaData.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/07/2026.
//

import Foundation

let defaults = UserDefaults()
private let mediaController = MediaControllers(rawValue: defaults.string(forKey: "mediaController") ?? "auto")

enum MediaControllers: String, CaseIterable, Identifiable, Codable {
    case spotify
    case spotifyIntegrated
    case nowPlaying
    case auto
    var id: Self { self }
}

@Observable class MediaData {
    var title: String?
    var artist: String?
    var timestamp: Date?
    var elapsedTime: TimeInterval?
    var playing: Bool?
    var duration: TimeInterval?
    
    private func initNowPlaying(_ controller: NowPlayingController) {
        controller.onTrackUpdate = { payload in
            if let title = payload.title {
                print(title)
                self.title = title
            }
            if let artist = payload.artist {
                print(artist)
                self.artist = artist
            }
            if let timestamp = payload.timestamp {
                print(timestamp)
                self.timestamp = ISO8601DateFormatter().date(from: timestamp)
            }
            if let elapsedTime = payload.elapsedTime {
                print(elapsedTime)
                self.elapsedTime = Double(elapsedTime)
            }
            if let playing = payload.playing {
                print(playing)
                self.playing = playing
            }
            if let duration = payload.duration {
                print(duration)
                self.duration = Double(duration)
            }
        }

    }
    
    let nowPlayingController = NowPlayingController()
    init() {
        switch mediaController {
        case .spotify:
            return
        case .spotifyIntegrated:
            return
        case .nowPlaying:
            initNowPlaying(nowPlayingController)
            nowPlayingController.startStreaming()
        case .auto:
            return
        default:
            return
        }
    }
}
