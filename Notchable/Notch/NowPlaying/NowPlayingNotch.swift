//
//  NowPlayingNotch.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import SwiftUI

let mediaData = MediaData()

var NowPlayingNotch = DynamicNotch() {
    NowPlayingNotchExpandedView(mediaData: mediaData)
} compactLeading: {
    NowPlayingNotchCompactLeadingView(mediaData: mediaData)
} compactTrailing: {
    NowPlayingNotchCompactTrailingView(mediaData: mediaData)
}
