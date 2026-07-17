//
//  NowPlayingNotch.swift
//  Notchable
//
//  Created by Oliver Belsey on 27/06/2026.
//

import SwiftUI
    
struct NowPlayingNotchExpandedView: View {
    var mediaData: MediaData
    var body: some View {
        VStack {
            HStack {
                Image(.sour)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 12))
                VStack {
                    Text(mediaData.title ?? "")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(mediaData.artist ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                }
            }
            switch mediaData.playing {
            case true:
                HStack {
                    Text(.currentDate, format: .timer(countingUpIn: (mediaData.timestamp?.addingTimeInterval(-(mediaData.elapsedTime ?? 0)) ?? Date.now)..<(mediaData.timestamp ?? Date.now) .addingTimeInterval(mediaData.duration ?? 0)))
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
                        Text(.currentDate, format: .timer(countingDownIn: (mediaData.timestamp ?? Date.now)..<(mediaData.timestamp?.addingTimeInterval(-(mediaData.elapsedTime ?? 0)) ?? Date.now) .addingTimeInterval(mediaData.duration ?? 0)))
                            .foregroundStyle(.secondary)
                    }
                }
            default:
                HStack {
                    Text(mediaData.elapsedTime?.minuteSecondFormat() ?? "0:00")
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
                    Text("-" + (mediaData.duration ?? 0 - (mediaData.elapsedTime ?? 0)).minuteSecondFormat())
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                Spacer()
                Button("Favourite", systemImage: "star.fill") {
                    
                }
                .font(.title)
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                
                Spacer()
                
                Button("Rewind", systemImage: "backward.fill") {
                    sendMediaCommand(.previousTrack)
                }
                .font(.title)
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                
                Spacer()
                switch mediaData.playing {
                case true:
                    Button("Pause", systemImage: "pause.fill") {
                        sendMediaCommand(.playPause)
                    }
                    .font(.largeTitle)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                default:
                    Button("Play", systemImage: "play.fill") {
                        sendMediaCommand(.playPause)
                    }
                    .font(.largeTitle)
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                }
                
                Spacer()
                
                Button("Forward", systemImage: "forward.fill") {
                    sendMediaCommand(.nextTrack)
                }
                .font(.title)
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                
                Spacer()
                
                Button("Airplay", systemImage: "airpods.pro") {
                    
                }
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
    var mediaData: MediaData
    var body: some View {
        HStack {
            Image(.sour)
        }
    }
}

struct NowPlayingNotchCompactTrailingView: View {
    var mediaData: MediaData
    var body: some View {
        HStack {
            Text(mediaData.title ?? "")
        }
    }
}


#Preview {
    NowPlayingNotch.expandedContent
}
