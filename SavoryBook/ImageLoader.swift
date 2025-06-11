//
//  ImageLoader.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/9/25.
//

import Foundation
import SwiftUI


@MainActor
class ImageLoader: ObservableObject {
    @Published var image: Image?

    private let url: URL
    private let cache = ImageCache.shared

    init(url: URL) {
        self.url = url
    }

    func load() async {
        let key = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString

        print("Attempting to load image for: \(url)")

        if let data = await cache.imageData(forKey: key),
           let uiImage = UIImage(data: data) {
            print("Loaded from cache: \(url)")
            self.image = Image(uiImage: uiImage)
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Downloaded from network: \(url)")

            cache.setImageData(data, forKey: key)

            if let uiImage = UIImage(data: data) {
                self.image = Image(uiImage: uiImage)
            }
        } catch {
            print(" Image load failed: \(error.localizedDescription)")
        }
    }
}
