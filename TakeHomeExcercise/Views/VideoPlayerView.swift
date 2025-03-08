//
//  VideoPlayerView.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoName: String
    @State private var player: AVPlayer?

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                if let cachedURL = VideoCacheManager.shared.getCachedVideoURL(for: videoName) ??
                                   VideoCacheManager.shared.cacheVideo(from: videoName) {
                    player = AVPlayer(url: cachedURL)
                    player?.play()
                }
            }
            .onDisappear {
                player?.pause()
            }
    }
}


