//
//  Post.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import Foundation

enum PostType {
    case image(name: String)
    case video(name: String)
    case mixed(imageName: String, videoName: String)
}
struct Post: Identifiable {
    let id = UUID()
    let type: PostType
}
