//
//  NowPlayingNotch.swift
//  Notchable
//
//  Created by Oliver Belsey on 14/07/2026.
//

import DynamicNotchKit
import SwiftUI

var NowPlayingNotch = DynamicNotch {
    NowPlayingNotchExpandedView()
} compactLeading: {
    NowPlayingNotchCompactLeadingView()
} compactTrailing: {
    NowPlayingNotchCompactTrailingView()
}
