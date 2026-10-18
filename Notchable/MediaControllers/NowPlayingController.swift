//
//  NowPlayingController.swift
//  Notchable
//
//  Created by Oliver Belsey on 17/10/26.
//

import Combine
import Foundation

class NowPlayingController: MediaControllerProtocol {
    @Published var musicData = MusicData()

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
    
    init() {}
    
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
    
//    private class MediaStreamer {
//        private var process: Process?
//        private var outputPipe: Pipe?
//        
//        var onTrackUpdate: ((MediaPayload) -> Void)?
//        
//        func startStreaming() {
//            guard
//                let scriptURL = Bundle.main.url(forResource: "mediaremote-adapter", withExtension: "pl"),
//                let frameworkPath = Bundle.main.privateFrameworksPath?.appending("/MediaRemoteAdapter.framework")
//            else {
//                print("Cannot find mediaremote-adapter resources")
//                return
//            }
//            
//            let process = Process()
//            let pipe = Pipe()
//            
//            process.executableURL = URL(fileURLWithPath: "/usr/bin/perl")
//            process.arguments = [scriptURL.path, frameworkPath, "stream", "--no-artwork"]
//            process.standardOutput = pipe
//            
//            self.process = process
//            outputPipe = pipe
//            
//            let fileHandle = pipe.fileHandleForReading
//            fileHandle.waitForDataInBackgroundAndNotify()
//            
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(handleDataAvailable(_:)),
//                name: NSNotification.Name.NSFileHandleDataAvailable,
//                object: fileHandle
//            )
//            
//            do {
//                try process.run()
//                print("Media Remote stream started")
//            } catch {
//                print("Failed to start Media Remote stream: \(error)")
//            }
//        }
//        
//        @objc private func handleDataAvailable(_ notification: Notification) {
//            guard
//                let fileHandle = notification.object as? FileHandle else { return }
//            let data = fileHandle.availableData
//            
//            if data.isEmpty {
//                print("Stream ended")
//                return
//            }
//            
//            if let outputString = String(data: data, encoding: .utf8) {
//                let lines = outputString.components(separatedBy: .newlines)
//                for line in lines {
//                    if !line.isEmpty {
//                        parseJSONLine(line)
//                    }
//                }
//            }
//            
//            fileHandle.waitForDataInBackgroundAndNotify()
//        }
//        
//        private func parseJSONLine(_ jsonString: String) {
//            print(jsonString)
//                    }
//        
//        func stopStreaming() {
//            process?.terminate()
//            process = nil
//            outputPipe = nil
//        }
//    }
}
