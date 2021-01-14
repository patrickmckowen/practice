//
//  Photos.swift
//  Practice
//
//  Created by Patrick McKowen on 10/3/20.
//

import SwiftUI
import Combine

struct BackgroundPhotos: Codable {
    let url: String
    let theme: String
}

struct Photo: View {
    @EnvironmentObject var manager: PhotoManager
    @State private var image = UIImage(named: "default")
    
    var body: some View {
        Image(uiImage: image!)
            .resizable()
            .scaledToFill()
            .onReceive(manager.didChange) { _ in
                reload()
            }
    }
    
    func reload() {
        self.image = manager.image
    }
}

class PhotoManager: ObservableObject {
    let photos: [BackgroundPhotos] = Bundle.main.decode("photos.json")
    var didChange = PassthroughSubject<(UIImage), Never>()
    var imageUrl: String?
    var image: UIImage?
    
    @Published var loading = true
    @Published var showUI = false
    @Published var isDarkImage = true
    @Published var prevPhotoIndex: Int = UserDefaults.standard.integer(forKey: "PrevPhotoIndex")
    
    func loadNewPhoto() {
        nextPhoto()
        loadPhotoFromUrl()
    }
    
    func nextPhoto() {
        var nextIndex: Int
        if prevPhotoIndex < photos.count - 1 {
            nextIndex = prevPhotoIndex + 1
        } else {
            nextIndex = 0
        }
        let photo = photos[nextIndex]
        imageUrl = photo.url
        
        if photo.theme == "dark" {
            isDarkImage = true
        } else {
            isDarkImage = false
        }
        
        prevPhotoIndex = nextIndex
        UserDefaults.standard.set(prevPhotoIndex, forKey: "PrevPhotoIndex")
    }
    
    func loadPhotoFromUrl() {
        guard let url = URL(string: imageUrl!) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.image = loadedImage
                self.didChange.send(self.image!)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear) {
                        self.loading = false
                    }
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.linear(duration: 1)) {
                        self.showUI = true
                    }
                    
                }
            }
        }
        task.resume()
    }
}
