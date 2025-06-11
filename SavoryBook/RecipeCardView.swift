//
//  RecipeCardView.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/6/25.
//
import Foundation
import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let urlString = recipe.photo_url_small,
               let url = URL(string: urlString) {
                AsyncCachedImage(url: url)
                    .frame(height: 200)
                    .clipped()
            } else {
                Color.gray
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }

            HStack {
                Text(recipe.name)
                    .font(.custom("Papyrus", size: 18))
                    .foregroundColor(.orange)
                    .lineLimit(1)
                    .bold()
                    .gradientForeground(colors: [Color.purple, Color.blue])

                Spacer()

                Text(recipe.cuisine)
                    .font(.custom("Papyrus", size: 15))
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
            }
            .padding()
        }
        .background(.thinMaterial)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}
