//
//  Recipe.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/6/25.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: UUID
    let name: String
    let cuisine: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photo_url_large
        case photo_url_small
        case source_url
        case youtube_url
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

