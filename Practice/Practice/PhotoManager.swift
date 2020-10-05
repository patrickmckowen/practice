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

class PhotoManager: ObservableObject {
    var urlString: String?
    
    @Published var image: UIImage?
    
    init(urlString: String) {
        self.urlString = urlString
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.image = loadedImage
            }
        }
        task.resume()
    }
}


struct PhotoView: View {
    @ObservedObject var photos: PhotoManager
    
    init(urlString: String) {
        photos = PhotoManager(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: photos.image ?? PhotoView.defaultImage!)
            .resizable()
    }
    
    static var defaultImage = UIImage(named: "image-placeholder")
}

struct PreviewView: View {
    let unsplash: [UnsplashPhotos] = Bundle.main.decode("images.json")
    @AppStorage("PrevIndex") var prevIndex = 0
    @EnvironmentObject var yogi: Yogi
    @State private var url = ""
    @State var isDarkImage: Bool = true
    
    var body: some View {
        ZStack {
            PhotoView(urlString: url)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: {
            updateImage()
        })
    }
    
    func updateImage() {
        let images = unsplash
        let newIndex = prevIndex + 1
        
        let img = images[newIndex]
        self.url = img.url
        if img.theme == "light" {
            self.isDarkImage = false
        }
        
        if newIndex < images.count - 1 {
            prevIndex = newIndex
        } else {
            prevIndex = -1
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        let yogi = Yogi()
        return PreviewView()
            .environmentObject(yogi)
    }
}
