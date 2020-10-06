//
//  Photos.swift
//  Practice
//
//  Created by Patrick McKowen on 10/3/20.
//

import SwiftUI

struct UnsplashPhotos: Codable {
    let name: String
    let url: String
    let theme: String
}

struct PhotoView: View {
    @StateObject var loader: ImageLoader
    static var defaultImage = UIImage(named: "image-placeholder")
    
    init(urlString: String) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
    }
    
    var body: some View {
        Image(uiImage: loader.image ?? PhotoView.defaultImage!)
            .resizable()
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String) {
        print("Starting image loader")
        self.urlString = urlString
        
        if loadImageFromCache() {
            return
        }
        loadImageFromURL()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }

        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        print("Image loaded from cache")
        return true
    }
    
    func loadImageFromURL() {
        guard let urlString = urlString else { return }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.imageCache.set(forKey: self.urlString!, image: loadedImage)
                self.image = loadedImage
                print("Image loaded from url")
            }
        }
        task.resume()
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
