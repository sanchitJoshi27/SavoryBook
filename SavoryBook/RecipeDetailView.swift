//
//  RecipeDetailView.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/6/25.
//

import Foundation
import SwiftUI


struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.openURL) var openURL

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.75),
                    Color.white.opacity(0.2)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    if let urlString = recipe.photo_url_large,
                       let url = URL(string: urlString) {
                        AsyncCachedImage(url: url)
                            .frame(maxHeight: 300)
                            .clipped()
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxHeight: 300)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                    }

                    Text(recipe.name)
                        .font(.custom("Papyrus", size: 40))
                        .bold()
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                        .gradientForeground(colors: [Color.purple, Color.blue])

                    Text("Cuisine: \(recipe.cuisine)")
                        .font(.custom("Papyrus-Condensed",size: 25))
                        .foregroundColor(.secondary)
                        .gradientForeground(colors: [Color.purple, Color.blue])
                    
                    VStack(spacing: 12) {
                        if let sourceURL = URL(string: recipe.source_url ?? "") {
                            Button("View Detailed Recipe") {
                                openURL(sourceURL)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .cornerRadius(8)
                            .buttonStyle(.bordered)
                        }

                        if let youtubeURL = URL(string: recipe.youtube_url ?? "") {
                            Button("Watch YouTube Video") {
                                openURL(youtubeURL)
                            }
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .padding(.horizontal)
                            .cornerRadius(8)
                            .buttonStyle(.bordered)
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding()
              
            }
        }
    }
}

