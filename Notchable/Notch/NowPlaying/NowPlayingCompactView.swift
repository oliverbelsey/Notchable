//
//  NowPlayingNotchViews.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI

struct NowPlayingNotchCompactLeadingView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        HStack {
            Image(imageData: mediaController?.musicData.artwork ?? Data())
        }
    }
}

struct NowPlayingNotchCompactTrailingView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        HStack {
            Text(MediaController.controller?.musicData.title ?? "")
        }
    }
}
