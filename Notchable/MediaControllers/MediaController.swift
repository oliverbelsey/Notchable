//
//  MediaController.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/10/26.
//

import Defaults

class MediaController {
    static var controller = (any MediaControllerProtocol)?(nilLiteral: ())

    @Default(.mediaController) private var mediaControllerType

    init() {
        switch mediaControllerType {
        case .nowPlaying:
            MediaController.controller = NowPlayingController()
        }
    }
}
