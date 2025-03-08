//  Untitled.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import SwiftUI
import AVKit

struct PostView: View {
    let post: Post
    @State private var player: AVPlayer?
    
    var body: some View {
        VStack {
            switch post.type {
            case .image(let name):
                loadCachedImage(named: name)
            case .video(let name):
                loadCachedVideo(named: name)
            case .mixed(let imageName, let videoName):
                TabView {
                    loadCachedImage(named: imageName)
                        .tag(0)
                    loadCachedVideo(named: videoName)
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
        }
        .frame(height: 320)
        .padding(.vertical, 2)
        .onAppear {
            preloadCache(for: post)
        }
    }
    
    // MARK: - Load Cached Image
    private func loadCachedImage(named name: String) -> some View {
        if let cachedImage = ImageCache.getImage(named: name) {
            return AnyView(
                Image(uiImage: cachedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .padding(.horizontal)
            )
        } else {
            return AnyView(
                ProgressView()
                    .frame(height: 300)
                    .onAppear {
                        _ = ImageCache.getImage(named: name)
                    }
            )
        }
    }
    
    // MARK: - Load Cached Video
    private func loadCachedVideo(named name: String) -> some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.frame(height: 300)

                VideoPlayer(player: player)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .padding(.horizontal, 10)
                    .onAppear {
                        if let cachedURL = VideoCacheManager.shared.getCachedVideoURL(for: name) ??
                                           VideoCacheManager.shared.cacheVideo(from: name) {
                            player = AVPlayer(url: cachedURL)
                        }
                    }
                    .onChange(of: geo.frame(in: .global).minY) { oldY, newY in
                        let screenHeight = UIScreen.main.bounds.height
                        let videoTop = newY
                        let videoBottom = videoTop + 300

                        if videoTop >= 0 && videoBottom <= screenHeight {
                            player?.play()
                        } else {
                            player?.pause()
                        }
                    }
                    .onDisappear {
                        player?.pause()
                    }
            }
        }
        .frame(height: 300)
    }

    
    // MARK: - Preload Cache for Performance
    private func preloadCache(for post: Post) {
        switch post.type {
        case .image(let name):
            _ = ImageCache.getImage(named: name)
        case .video(let name):
            _ = VideoCacheManager.shared.cacheVideo(from: name)
        case .mixed(let imageName, let videoName):
            _ = ImageCache.getImage(named: imageName)
            _ = VideoCacheManager.shared.cacheVideo(from: videoName)
        }
    }
}


