//
//  FeedViewModel.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    init() {
        loadDummyData()
    }

    private func loadDummyData() {
        posts = [
            Post(type: .image(name: "image_1")),
            Post(type: .video(name: "video_1")),
            Post(type: .mixed(imageName: "image_11", videoName: "video_2")),
            Post(type: .image(name: "image_2")),
            Post(type: .video(name: "video_3")),
            Post(type: .mixed(imageName: "image_12", videoName: "video_4")),
            Post(type: .image(name: "image_3")),
            Post(type: .video(name: "video_5")),
            Post(type: .mixed(imageName: "image_13", videoName: "video_6")),
            Post(type: .image(name: "image_4")),
            Post(type: .image(name: "image_5")),
            Post(type: .video(name: "video_7")),
            Post(type: .image(name: "image_6")),
            Post(type: .image(name: "image_7")),
            Post(type: .video(name: "video_8")),
            Post(type: .image(name: "image_8")),
            Post(type: .image(name: "image_9")),
            Post(type: .video(name: "video_9")),
            Post(type: .mixed(imageName: "image_14", videoName: "video_10")),
            Post(type: .image(name: "image_10"))
        ]
    }

}
