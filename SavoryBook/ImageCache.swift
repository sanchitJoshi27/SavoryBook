//
//  ImageCache.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/9/25.
//

import Foundation
import SwiftUI

final class ImageCache {
    static let shared = ImageCache()

    private let memoryCache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let ioQueue = DispatchQueue(label: "com.savorybook.imagecache")

    private init() {}

    func imageData(forKey key: String) async -> Data? {
        if let data = memoryCache.object(forKey: key as NSString) {
            return Data(referencing: data)
        }

        let fileURL = cacheDirectory().appendingPathComponent(key)

        return await withCheckedContinuation { continuation in
            ioQueue.async {
                guard self.fileManager.fileExists(atPath: fileURL.path),
                      let data = try? Data(contentsOf: fileURL) else {
                    continuation.resume(returning: nil)
                    return
                }

                self.memoryCache.setObject(NSData(data: data), forKey: key as NSString)
                continuation.resume(returning: data)
            }
        }
    }

    func setImageData(_ data: Data, forKey key: String) {
        memoryCache.setObject(NSData(data: data), forKey: key as NSString)

        let fileURL = cacheDirectory().appendingPathComponent(key)

        ioQueue.async {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    private func cacheDirectory() -> URL {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let dir = paths[0].appendingPathComponent("ImageCache", isDirectory: true)

        if !fileManager.fileExists(atPath: dir.path) {
            try? fileManager.createDirectory(at: dir, withIntermediateDirectories: true)
        }

        return dir
    }
}
