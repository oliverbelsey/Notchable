import SwiftUI

struct LockScreenNowPlayingView: View {
    // State variables for dynamic controls
    @State private var isPlaying: Bool = true
    @State private var progress: Double = 0.35 // 35% completed
    
    var body: some View {
        VStack(spacing: 12) {
            // MARK: - Top Section: Artwork, Track Info, and AirPlay
            HStack(spacing: 12) {
                // Album Art
                Image(systemName: "music.note.house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 54, height: 54)
                    .background(
                        LinearGradient(
                            colors: [.purple, .indigo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)

                // Track & Artist Title
                VStack(alignment: .leading, spacing: 2) {
                    Text("Midnight City")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text("M83")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.6))
                        .lineLimit(1)
                }
                
                Spacer()
                
                // AirPlay Icon
                Button(action: {}) {
                    Image(systemName: "airplayaudio")
                        .font(.system(size: 20))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            // MARK: - Progress Bar & Timestamps
            VStack(spacing: 6) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Track background
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 4)
                        
                        // Active progress fill
                        Capsule()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * CGFloat(progress), height: 4)
                    }
                }
                .frame(height: 4)
                
                // Duration Labels
                HStack {
                    Text("1:24")
                    Spacer()
                    Text("-2:39")
                }
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(.white.opacity(0.5))
            }
            
            // MARK: - Playback Controls
            HStack {
                
                Button("previousTrack", systemImage: "backward.fill") {
                    
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
                
                Button("pause", systemImage: "pause.fill") {
                    isPlaying.toggle()
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)

                
                Button("nextTrack", systemImage: "forward.fill") {
                    
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)

            }
        }
        .padding()
    }
}

// MARK: - Canvas Preview
#Preview {
    LockScreenNowPlayingView()
}
