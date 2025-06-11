//
//  RecipeViewModel.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/6/25.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = "" {
        didSet {
            filterRecipes()
        }
    }
    @Published var selectedCuisine: String? = nil {
        didSet {
            filterRecipes()
        }
    }

    @Published var isLoading = false
    @Published var errorMessage: String?

    private var apiURL: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    var availableCuisines: [String] {
        Set(allRecipes.map { $0.cuisine }).sorted()
    }

    func setAPIURL(_ url: URL) {
        self.apiURL = url
    }

    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(from: apiURL)
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            self.allRecipes = decoded.recipes
            filterRecipes()
        } catch {
            errorMessage = error.localizedDescription
            self.recipes = []
        }

        isLoading = false
    }

    private func filterRecipes() {
        var filtered = allRecipes

        if let selected = selectedCuisine {
            filtered = filtered.filter { $0.cuisine == selected }
        }

        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }

        self.recipes = filtered
    }
}
