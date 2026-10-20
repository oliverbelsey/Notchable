//
//  Notches.swift
//  Notchable
//
//  Created by Oliver Belsey on 20/10/26.
//

import DynamicNotchKit
import SwiftUI

private let musicData = MusicData()

enum Notches {
    static let nowPlaying = DynamicNotch {
        NowPlayingNotchExpandedView(musicData: musicData)
    } compactLeading: {
        NowPlayingNotchCompactLeadingView(musicData: musicData)
    } compactTrailing: {
        NowPlayingNotchCompactTrailingView(musicData: musicData)
    }
}
