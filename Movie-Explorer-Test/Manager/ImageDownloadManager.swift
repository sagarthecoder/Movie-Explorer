//
//  ImageDownloadManager.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import UIKit

class ImageDownloadManager {
    
    private init() {}
    
    static let shared = ImageDownloadManager()
    private let imageCache = ImageCachingManager()

    func downloadImage(from url: URL) async throws -> UIImage? {
        if let cachedImage = imageCache.image(for: url) {
            return cachedImage
        }

        let data = try await downloadImageData(from: url)
        guard let image = UIImage(data: data) else {
            return nil
        }
        imageCache.cacheImage(image, for: url)
        return image
    }
    
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
