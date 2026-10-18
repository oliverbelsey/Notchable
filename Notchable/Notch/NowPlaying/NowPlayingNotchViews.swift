//
//  NowPlayingNotchViews.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI
    
struct NowPlayingNotchExpandedView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        VStack {
            HStack {
                Image(imageData: mediaController?.musicData.artwork ?? Data())
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 12))
                VStack {
                    Text(mediaController?.musicData.title ?? "")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(mediaController?.musicData.artist ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                }
            }
            switch mediaController?.musicData.playing {
            case true:
                HStack {
                    Text(.currentDate, format: .timer(countingUpIn: (mediaController?.musicData.timestamp.addingTimeInterval(-(mediaController?.musicData.elapsedTime ?? 0)) ?? Date.now) ..< (mediaController?.musicData.timestamp ?? Date.now).addingTimeInterval(mediaController?.musicData.duration ?? 0)))
                        .foregroundStyle(.secondary)
                    ZStack {
                        Capsule()
                            .frame(height: 7)
                            .foregroundStyle(.tertiary)
                        Rectangle()
                            .frame(height: 7)
                            .clipShape(.capsule)
                            .foregroundStyle(.secondary)
                    }
                    HStack(spacing: 0) {
                        Text("-")
                            .foregroundStyle(.secondary)
                        Text(.currentDate, format: .timer(countingDownIn: (mediaController?.musicData.timestamp ?? Date.now) ..< (mediaController?.musicData.timestamp.addingTimeInterval(-(mediaController?.musicData.elapsedTime ?? 0)) ?? Date.now).addingTimeInterval(mediaController?.musicData.duration ?? 0)))
                            .foregroundStyle(.secondary)
                    }
                }
            default:
                HStack {
                    Text(mediaController?.musicData.elapsedTime.minuteSecondFormat() ?? "0:00")
                        .foregroundStyle(.secondary)
                    ZStack {
                        Capsule()
                            .frame(height: 7)
                            .foregroundStyle(.tertiary)
                        Rectangle()
                            .frame(height: 7)
                            .clipShape(.capsule)
                            .foregroundStyle(.secondary)
                    }
                    Text("-" + (mediaController?.musicData.duration ?? 0 - (mediaController?.musicData.elapsedTime ?? 0)).minuteSecondFormat())
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                Spacer()
                Button("Favourite", systemImage: "star.fill") {}
                    .font(.title)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                
                Spacer()
                
                Button("Rewind", systemImage: "backward.fill") {
                    Task {
                        await mediaController?.previousTrack()
                    }
                }
                .font(.title)
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                
                Spacer()
                switch mediaController?.musicData.playing {
                case true:
                    Button("Pause", systemImage: "pause.fill") {
                        Task {
                            await mediaController?.playPause()
                        }
                    }
                    .font(.largeTitle)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                default:
                    Button("Play", systemImage: "play.fill") {
                        Task {
                            await mediaController?.playPause()
                        }
                    }
                    .font(.largeTitle)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                }
                
                Spacer()
                
                Button("Forward", systemImage: "forward.fill") {
                    Task {
                        await mediaController?.nextTrack()
                    }
                }
                .font(.title)
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                
                Spacer()
                
                Button("Airplay", systemImage: "airpods.pro") {}
                    .font(.title)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                
                Spacer()
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .frame(width: 250, height: 125)
    }
}

struct NowPlayingNotchCompactLeadingView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        HStack {
            Image(.sour)
        }
    }
}

struct NowPlayingNotchCompactTrailingView: View {
    private var mediaController = MediaController.controller
    var body: some View {
        HStack {
            Text(mediaController?.musicData.title ?? "")
        }
    }
}

#Preview {
    NowPlayingNotchExpandedView()
}
