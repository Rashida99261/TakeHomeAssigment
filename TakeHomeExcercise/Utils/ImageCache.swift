//
//  ImageCache.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()

    static func getImage(named name: String) -> UIImage? {
        if let cachedImage = shared.object(forKey: name as NSString) {
            return cachedImage
        }
        
        guard let image = UIImage(named: name) else { return nil }
        shared.setObject(image, forKey: name as NSString)
        return image
    }
}
