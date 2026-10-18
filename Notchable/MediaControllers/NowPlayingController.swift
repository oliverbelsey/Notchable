//
//  NowPlayingController.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/10/26.
//

import Combine
import Foundation

@Observable
class NowPlayingController: MediaControllerProtocol {
    var musicData = MusicData()
    private var streamer: MediaStreamer
    
    init() {
        streamer = MediaStreamer()
        streamer.onTrackUpdate = { payload in
            if let title = payload.title {
                self.musicData.title = title
            }
            if let artist = payload.artist {
                self.musicData.artist = artist
            }
            if let timestamp = payload.timestamp {
                self.musicData.timestamp = ISO8601DateFormatter().date(from: timestamp)!
            }
            if let elapsedTime = payload.elapsedTime {
                self.musicData.elapsedTime = Double(elapsedTime)
            }
            if let playing = payload.playing {
                self.musicData.playing = playing
            }
            if let duration = payload.duration {
                self.musicData.duration = Double(duration)
            }
            if let artworkString = payload.artworkData,
               let artworkData = Data(base64Encoded: artworkString)
            {
                self.musicData.artwork = artworkData
            }
        }
        streamer.startStreaming()
    }

    func play() async {
        sendCommand("send 0")
    }
    
    func pause() async {
        sendCommand("send 1")
    }
    
    func playPause() async {
        sendCommand("send 2")
    }
    
    func nextTrack() async {
        sendCommand("send 4")
    }
    
    func previousTrack() async {
        sendCommand("send 5")
    }
    
    func toggleShuffle() async {
        sendCommand("send 6")
    }
    
    func toggleRepeat() async {
        sendCommand("send 7")
    }
    
    func rewind15() async {
        sendCommand("send 12")
    }
    
    func skip15() async {
        sendCommand("send 13")
    }
    
    private func sendCommand(_ command: String) {
        guard
            let scriptURL = Bundle.main.url(forResource: "mediaremote-adapter", withExtension: "pl"),
            let frameworkPath = Bundle.main.privateFrameworksPath?.appending("/MediaRemoteAdapter.framework")
        else {
            print("Cannot find mediaremote-adapter resources")
            return
        }
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
        
        let commandArgs = command.components(separatedBy: " ")
        process.arguments = [scriptURL.path, frameworkPath] + commandArgs

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try process.run()
                process.waitUntilExit()
                
                if process.terminationStatus != 0 {
                    print("Media Remote process exited with code: \(process.terminationStatus)")
                }
            } catch {
                print("Failed to run Media Remote process: \(error)")
            }
        }
    }
    
    private class MediaStreamer {
        struct MediaPayload: Codable {
            var title: String?
            var artist: String?
            var timestamp: String?
            var elapsedTime: Float?
            var playing: Bool?
            var duration: Float?
            var artworkData: String?
        }
        
        struct StreamEvent: Codable {
            var type: String
            var diff: Bool
            var payload: MediaPayload
        }
        
        private var process: Process?
        private var outputPipe: Pipe?
        private var buffer = Data()
        
        var onTrackUpdate: ((MediaPayload) -> Void)?
        
        func startStreaming() {
            guard
                let scriptURL = Bundle.main.url(forResource: "mediaremote-adapter", withExtension: "pl"),
                let frameworkPath = Bundle.main.privateFrameworksPath?.appending("/MediaRemoteAdapter.framework")
            else {
                print("Cannot find mediaremote-adapter resources")
                return
            }
            
            let process = Process()
            let pipe = Pipe()
            
            process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
            process.arguments = [scriptURL.path, frameworkPath, "stream"]
            process.standardOutput = pipe
            
            self.process = process
            outputPipe = pipe
            
            let fileHandle = pipe.fileHandleForReading
            fileHandle.waitForDataInBackgroundAndNotify()
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleDataAvailable(_:)),
                name: NSNotification.Name.NSFileHandleDataAvailable,
                object: fileHandle
            )
            
            do {
                try process.run()
                print("Media Remote stream started")
            } catch {
                print("Failed to start Media Remote stream: \(error)")
            }
        }
        
        @objc private func handleDataAvailable(_ notification: Notification) {
            guard
                let fileHandle = notification.object as? FileHandle else { return }
            let data = fileHandle.availableData
            
            if data.isEmpty {
                print("Stream ended")
                return
            }
            
            buffer.append(data)
            
            let newLine = UInt8(ascii: "\n")
            while let index = buffer.firstIndex(of: newLine) {
                let lineData = buffer.subdata(in: buffer.startIndex ..< index)
                buffer.removeSubrange(buffer.startIndex ... index)
                if !lineData.isEmpty {
                    parseJSONLine(lineData)
                }
            }
            
            fileHandle.waitForDataInBackgroundAndNotify()
        }
        
        private func parseJSONLine(_ lineData: Data) {
            do {
                let event = try JSONDecoder().decode(StreamEvent.self, from: lineData)
                
                DispatchQueue.main.async {
                    self.onTrackUpdate?(event.payload)
                }
            } catch {
                print("Skipping non-JSON or malformed line: \(error)")
            }
        }
        
        func stopStreaming() {
            process?.terminate()
            process = nil
            outputPipe = nil
        }
    }
}
