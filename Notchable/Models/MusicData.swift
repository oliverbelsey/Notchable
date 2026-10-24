//
//  MusicData.swift
//  Notchable
//
//  Created by Oliver Belsey on 18/10/26.
//

import Foundation

struct MusicData {
    var title: String = "Traitor"
    var artist: String = "Olivia Rodrigo"
    var timestamp: Date = .now
    var elapsedTime: TimeInterval = 56
    var playing: Bool = false
    var duration: TimeInterval = 229
    var shuffling: Bool = true
    var artwork: Data?
}
