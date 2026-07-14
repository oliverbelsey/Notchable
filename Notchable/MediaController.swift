//
//  MediaController.swift
//  Notchable
//
//  Created by Oliver Belsey on 09/07/2026.
//

import Foundation

enum MediaCommand: String {
    case play = "send 0"
    case pause = "send 1"
    case playPause = "send 2"
    case nextTrack = "send 4"
    case previousTrack = "send 5"
    case toggleShuffle = "send 6"
    case toggleRepeat = "send 7"
    case rewind15 = "send 12"
    case skip15 = "send 13"
}

func sendMediaCommand(_ command: MediaCommand) {
    guard
        let scriptURL = Bundle.main.url(forResource: "mediaremote-adapter", withExtension: "pl"),
        let frameworkPath = Bundle.main.privateFrameworksPath?.appending("/MediaRemoteAdapter.framework")
    else {
        print("Cannot find mediaremote-adapter resources")
        return
    }
    
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
    
    let commandArgs = command.rawValue.components(separatedBy: " ")
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

struct MediaPayload: Codable {
    var title: String?
    var artist: String?
    var timestamp: String?
    var elapsedTime: Float?
    var playing: Bool?
    var duration: Float?
}

struct StreamEvent: Codable {
    var type: String
    var diff: Bool
    var payload: MediaPayload
}

class MediaStreamer {
    private var process: Process?
    private var outputPipe: Pipe?
    
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
        process.arguments = [scriptURL.path, frameworkPath, "stream", "--no-artwork"]
        process.standardOutput = pipe
        
        self.process = process
        self.outputPipe = pipe
        
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
        
//        do {
//            print(String(data: data, encoding: .utf8)!)
//            let event = try JSONDecoder().decode(StreamEvent.self, from: data)
//            print("Formatted in json")
//            //let payload = try JSONDecoder().decode(MediaPayload, from: )
//            DispatchQueue.main.async {
//                self.onTrackUpdate?(event.payload)
//            }
//        } catch {
//            print("Not formatted in json: \(error)")
//        }
        
        if let outputString = String(data: data, encoding: .utf8) {
            let lines = outputString.components(separatedBy: .newlines)
            for line in lines  {
                if !line.isEmpty {
                    parseJSONLine(line)
                }
            }
        }
        
        fileHandle.waitForDataInBackgroundAndNotify()
    }
    
    private func parseJSONLine(_ jsonString: String) {
        print(jsonString)
        guard let data = jsonString.data(using: .utf8) else { return }
        
        do {
            let event = try JSONDecoder().decode(StreamEvent.self, from: data)
            
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

@Observable class MusicData {
    var title: String?
    var artist: String?
    var timestamp: Date?
    var elapsedTime: TimeInterval?
    var playing: Bool?
    var duration: TimeInterval?
    
    let streamer = MediaStreamer()
    init() {
        streamer.onTrackUpdate = { payload in
            if let title = payload.title {
                print("hi")
                self.title = title
            }
            if let artist = payload.artist {
                self.artist = artist
            }
            if let timestamp = payload.timestamp {
                self.timestamp = ISO8601DateFormatter().date(from: timestamp)
            }
            if let elapsedTime = payload.elapsedTime {
                self.elapsedTime = Double(elapsedTime)
            }
            if let playing = payload.playing {
                self.playing = playing
            }
            if let duration = payload.duration {
                self.duration = Double(duration)
            }
        }
        
        streamer.startStreaming()
    }
}
