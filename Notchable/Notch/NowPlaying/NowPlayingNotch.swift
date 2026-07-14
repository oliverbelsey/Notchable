//
//  NowPlayingNotch.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import SwiftUI

let musicData = MusicData()

var NowPlayingNotch = DynamicNotch() {
    NowPlayingNotchExpandedView(musicData: musicData)
} compactLeading: {
    NowPlayingNotchCompactLeadingView(musicData: musicData)
} compactTrailing: {
    NowPlayingNotchCompactTrailingView(musicData: musicData)
}
