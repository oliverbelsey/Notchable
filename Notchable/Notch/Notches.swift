//
//  Notches.swift
//  Notchable
//
//  Created by Oliver Belsey on 20/10/26.
//

import DynamicNotchKit
import SwiftUI

enum Notches {
    static let nowPlaying = DynamicNotch {
        NowPlayingNotchExpandedView()
    } compactLeading: {
        NowPlayingNotchCompactLeadingView()
    } compactTrailing: {
        NowPlayingNotchCompactTrailingView()
    }
}
