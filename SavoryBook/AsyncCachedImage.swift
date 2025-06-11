//
//  AsyncCachedImage.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/9/25.
//

import Foundation
import SwiftUI

struct AsyncCachedImage: View {
    let url: URL
    var placeholder: Image = Image(systemName: "photo")

    @StateObject private var loader: ImageLoader

    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Color.gray.opacity(0.2)
                    ProgressView()
                }
            }
        }
        .task {
            await loader.load()
        }
    }
}
