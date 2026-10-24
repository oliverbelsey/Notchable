//
//  MediaControllerProtocol.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/10/26.
//

import Foundation

protocol MediaControllerProtocol {
    func play() async
    func pause() async
    func playPause() async
    func nextTrack() async
    func previousTrack() async
    func toggleShuffle() async
    func toggleRepeat() async
    func rewind15() async
    func skip15() async

    var musicData: MusicData { get set }
}
