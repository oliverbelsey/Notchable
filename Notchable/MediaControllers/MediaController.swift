//
//  MediaController.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/07/2026.
//

import Foundation
import Combine

class MediaController: Observable, ObservableObject {
//    let objectWillChange: ObservableObjectPublisher
    
    private var mediaController: MediaControllers
    @Published var newController: (any MediaControllerProtocol)?
    
    private func initNowPlayingController() {
        newController = NowPlayingController()
    }
    
    private func initSpotifyController() {
        
    }
    
    private func initSpotifyIntegratedController() {
        
    }
    
    init(objectWillChange: ObservableObjectPublisher, mediaController: MediaControllers? = nil, newController: (any MediaControllerProtocol)? = nil) {
//        self.objectWillChange = objectWillChange
        self.mediaController = MediaControllers(rawValue: defaults.string(forKey: "mediaController") ?? "nowPlaying")!
        self.newController = switch MediaControllers(rawValue: defaults.string(forKey: "mediaController") ?? "nowPlaying")! {
        case.nowPlaying:
            NowPlayingController()
        default:
            nil
        }
    }
}
