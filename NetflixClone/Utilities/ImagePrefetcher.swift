//
//  ImagePrefetcher.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 05/06/25.
//

import UIKit

// Image cache singleton
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private init() {}

    func getImage(for url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }

    func setImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}

// Image prefetcher singleton that handles both prefetching and loading
class ImagePrefetcher {
    static let shared = ImagePrefetcher()
    private let prefetchQueue = DispatchQueue(label: "com.netflix.imagePrefetching", qos: .utility)
    private var pendingUrls = Set<String>()
    private var prefetchedUrls = Set<String>()
    private let cache = ImageCache.shared

    private init() {}

    // Load an image either from cache or network with completion handler
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        // Try to load from cache first
        if let cachedImage = cache.getImage(for: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        // If not in cache, fetch from network
        fetchImage(url: url) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    // Prefetch images that will be needed soon
    func prefetchImage(url: String) {
        // Don't prefetch if already in cache or being prefetched
        guard !prefetchedUrls.contains(url) && !pendingUrls.contains(url) else {
            return
        }

        prefetchQueue.async { [weak self] in
            guard let self = self else { return }
            self.fetchImage(url: url) { _ in }
        }
    }

    // Common image fetching logic
    private func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        // Skip if already in cache
        if let cachedImage = cache.getImage(for: url) {
            completion(cachedImage)
            return
        }

        // Skip if already being fetched
        guard !pendingUrls.contains(url) else {
            return
        }

        // Add to pending set
        pendingUrls.insert(url)

        guard let imageURL = URL(string: url) else {
            pendingUrls.remove(url)
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            defer {
                DispatchQueue.main.async {
                    self?.pendingUrls.remove(url)
                    self?.prefetchedUrls.insert(url)
                }
            }

            guard let self = self, let data = data, error == nil,
                    let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setImage(image, for: url)
            completion(image)
        }.resume()
    }
}
