//
//  Constants.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/10/26.
//

import Defaults

enum MediaControllerType: String, CaseIterable, Defaults.Serializable {
    case nowPlaying = "Now Playing"
}

extension Defaults.Keys {
    static let mediaController = Key<MediaControllerType>("mediaController", default: .nowPlaying)
}
