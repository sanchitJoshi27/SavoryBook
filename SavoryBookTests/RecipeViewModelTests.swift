//
//  RecipeViewModelTests.swift
//  SavoryBookTests
//
//  Created by Sanchit Joshi on 6/10/25.
//

import XCTest
@testable import SavoryBook

final class RecipeViewModelTests: XCTestCase {

    func testSuccessfulFetch() async {
        let viewModel = await RecipeViewModel()
        await viewModel.fetchRecipes()

        let recipes = await viewModel.recipes
        let error = await viewModel.errorMessage

        XCTAssertFalse(recipes.isEmpty, "Expected recipes to be loaded.")
        XCTAssertNil(error, "Expected no error on valid fetch.")
    }

    func testMalformedData() async {
        let viewModel = await RecipeViewModel()
        await viewModel.setAPIURL(URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!)
        await viewModel.fetchRecipes()

        let recipes = await viewModel.recipes
        let error = await viewModel.errorMessage

        XCTAssertTrue(recipes.isEmpty, "Recipes should be empty on malformed data.")
        XCTAssertNotNil(error, "Expected error message for malformed data.")
    }

    func testEmptyData() async {
        let viewModel = await RecipeViewModel()
        await viewModel.setAPIURL(URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!)
        await viewModel.fetchRecipes()

        let recipes = await viewModel.recipes
        let error = await viewModel.errorMessage

        XCTAssertTrue(recipes.isEmpty, "No recipes should be loaded for empty data.")
        XCTAssertNil(error, "Should not show error for empty but valid JSON.")
    }

    func testSearchAndFilter() async {
        let viewModel = await RecipeViewModel()
        await MainActor.run {
            viewModel.allRecipes = [
                Recipe(
                    id: UUID(),
                    name: "Apam Balik",
                    cuisine: "Malaysian",
                    photo_url_large: nil,
                    photo_url_small: nil,
                    source_url: nil,
                    youtube_url: nil
                ),
                Recipe(
                    id: UUID(),
                    name: "Pancakes",
                    cuisine: "American",
                    photo_url_large: nil,
                    photo_url_small: nil,
                    source_url: nil,
                    youtube_url: nil
                ),
                Recipe(
                    id: UUID(),
                    name: "Key Lime Pie",
                    cuisine: "American",
                    photo_url_large: nil,
                    photo_url_small: nil,
                    source_url: nil,
                    youtube_url: nil
                )
            ]
            viewModel.searchText = "Panc"
        }

        await MainActor.run {
            XCTAssertEqual(
                viewModel.recipes.map(\.name),
                ["Pancakes"],
                "Should return only Pancakes"
            )
        }

        await MainActor.run {
            viewModel.searchText = ""
            viewModel.selectedCuisine = "American"
        }

        await MainActor.run {
            let expectedNames = ["Pancakes", "Key Lime Pie"]
            XCTAssertEqual(
                viewModel.recipes.map(\.name).sorted(),
                expectedNames.sorted(),
                "Should return all American cuisine recipes regardless of case"
            )
        }
    }

}
