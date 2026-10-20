//
//  NowPlayingNotchViews.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI

struct NowPlayingNotchCompactLeadingView: View {
    var musicData: MusicData
    var body: some View {
        HStack {
            Image(.sour)
        }
    }
}

struct NowPlayingNotchCompactTrailingView: View {
    var musicData: MusicData
    var body: some View {
        HStack {
            Text(musicData.title ?? "")
        }
    }
}
