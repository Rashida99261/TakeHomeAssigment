//
//  VideoCacheManager.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import Foundation
import AVKit

class VideoCacheManager {
    static let shared = VideoCacheManager()
    
    private let fileManager = FileManager.default
    private var cacheDirectory: URL {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func getCachedVideoURL(for name: String) -> URL? {
        let fileURL = cacheDirectory.appendingPathComponent("\(name).mp4")
        return fileManager.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
    
    func cacheVideo(from bundleName: String) -> URL? {
        let destinationURL = cacheDirectory.appendingPathComponent("\(bundleName).mp4")

        if fileManager.fileExists(atPath: destinationURL.path) {
            return destinationURL
        }

        guard let bundleURL = Bundle.main.url(forResource: bundleName, withExtension: "mp4") else {
            return nil
        }

        do {
            try fileManager.copyItem(at: bundleURL, to: destinationURL)
            return destinationURL
        } catch {
            print("Failed to cache video: \(error)")
            return nil
        }
    }
}
