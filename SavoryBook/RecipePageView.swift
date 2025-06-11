//
//  RecipePageView.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/6/25.
//
import SwiftUI

struct RecipePageView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var selectedRecipe: Recipe?
    
    
    var body: some View {
        NavigationStack {
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
                
                VStack(spacing: 8) {
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            ZStack(alignment: .trailing) {
                                TextField("Search recipes...", text: $viewModel.searchText)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                if !viewModel.searchText.isEmpty {
                                    Button(action: {
                                        withAnimation {
                                            viewModel.searchText = ""
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                    .transition(.opacity)
                                }
                            }
                            
                            Menu {
                                Picker("Cuisine", selection: $viewModel.selectedCuisine) {
                                    Text("All").tag(String?.none)
                                    ForEach(viewModel.availableCuisines, id: \.self) {
                                        Text($0).tag(Optional($0))
                                    }
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray6))
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.orange)
                                }
                                .frame(width: 40, height: 40)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 16)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if viewModel.isLoading {
                                ProgressView("Loading Recipes...")
                                    .padding(.top, 40)
                            } else if let error = viewModel.errorMessage {
                                Text(error)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 40)
                            } else if viewModel.recipes.isEmpty {
                                Text("No recipes available.")
                                    .foregroundColor(.gray)
                                    .padding(.top, 40)
                            } else {
                                LazyVStack(spacing: 20) {
                                    ForEach(viewModel.recipes) { recipe in
                                        RecipeCardView(recipe: recipe)
                                            .onTapGesture {
                                                selectedRecipe = recipe
                                            }
                                    }
                                }
                                .padding()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                }
            }
            .navigationTitle("Recipes")
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .task {
                await viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipePageView()
}
