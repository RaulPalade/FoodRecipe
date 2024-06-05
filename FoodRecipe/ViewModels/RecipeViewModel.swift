//
//  RecipeViewModel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//
import Combine
import Firebase
import FirebaseFirestore
import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    let db: Firestore
    let recipesRef: CollectionReference

    @Published var recipes: [RecipeViewData] = []
    @Published var myFavRecipes: [RecipeViewData] = []
    @Published var filteredRecipes: [RecipeViewData] = []
    @Published var recipesByAuthor: [RecipeViewData] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = true

    private var cancellables = Set<AnyCancellable>()

    init() {
        db = Firestore.firestore()
        recipesRef = db.collection("recipes")
        fetchRecipes()
    }

    func fetchRecipes() {
        let queryPublisher = Future<[RecipeViewData], Error> { promise in
            Task {
                do {
                    let recipes = try await self.getRecipes()
                    let recipeViewDataList = try await self.loadImages(for: recipes)
                    promise(.success(recipeViewDataList))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)

        queryPublisher
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = "Error getting documents: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { recipes in
                self.recipes = recipes
                self.filteredRecipes = recipes
                self.isLoading = false
            }
            .store(in: &cancellables)
    }

    func getRecipes() async throws -> [Recipe] {
        var fetchedRecipes: [Recipe] = []

        let querySnapshot = try await recipesRef.getDocuments()

        for document in querySnapshot.documents {
            let documentID = document.documentID
            let data = document.data()

            if let name = data["name"] as? String,
               let description = data["description"] as? String,
               let category = data["category"] as? [String],
               let instructions = data["instructions"] as? [String],
               let nutritionData = data["nutrition"] as? [String: Double],
               let authorData = data["author"] as? [String: String],
               let rating = data["rating"] as? Double,
               let time = data["time"] as? String,
               let imageUrl = data["imageUrl"] as? String,
               let ingredientsData = data["ingredients"] as? [[String: Any]],
               let createdAt = data["createdAt"] as? String {
                // Conversione manuale degli ingredienti
                var ingredients: [RecipeIngredient] = []
                for ingredientData in ingredientsData {
                    if let name = ingredientData["name"] as? String,
                       let quantity = ingredientData["quantity"] as? String {
                        let ingredient = RecipeIngredient(name: name, quantity: quantity)
                        ingredients.append(ingredient)
                    } else {
                        print("Error: Missing required fields in ingredient data.")
                    }
                }

                let nutrition = Nutrition(
                    calories: nutritionData["calories"] ?? 0,
                    carbs: nutritionData["carbs"] ?? 0,
                    proteins: nutritionData["proteins"] ?? 0,
                    fats: nutritionData["fats"] ?? 0
                )

                let author = RecipeAuthor(
                    authorId: authorData["authorId"] ?? "",
                    name: authorData["name"] ?? "",
                    about: authorData["about"] ?? "",
                    imageUrl: authorData["imageUrl"] ?? ""
                )

                let recipe = Recipe(
                    id: documentID,
                    name: name,
                    description: description,
                    category: category,
                    ingredients: ingredients,
                    instructions: instructions,
                    nutrition: nutrition,
                    author: author,
                    rating: rating,
                    time: time,
                    createdAt: createdAt,
                    imageUrl: imageUrl
                )

                fetchedRecipes.append(recipe)
            } else {
                print("Error: Missing required fields in document data.")
            }
        }

        return fetchedRecipes
    }

    func loadImages(for recipes: [Recipe]) async throws -> [RecipeViewData] {
        var recipeViewDataList: [RecipeViewData] = []

        for recipe in recipes {
            guard let recipeImageUrl = URL(string: recipe.imageUrl),
                  let authorImageUrl = URL(string: recipe.author.imageUrl) else {
                throw URLError(.badURL)
            }

            async let recipeImageData = URLSession.shared.data(from: recipeImageUrl)
            async let authorImageData = URLSession.shared.data(from: authorImageUrl)

            let (recipeData, _) = try await recipeImageData
            let (authorData, _) = try await authorImageData

            if let recipeImage = UIImage(data: recipeData),
               let authorImage = UIImage(data: authorData) {
                let authorViewData = RecipeAuthorViewData(
                    authorId: recipe.author.authorId,
                    name: recipe.author.name,
                    about: recipe.author.about,
                    image: authorImage
                )

                let recipeViewData = RecipeViewData(
                    id: recipe.id,
                    name: recipe.name,
                    description: recipe.description,
                    category: recipe.category,
                    ingredients: recipe.ingredients,
                    instructions: recipe.instructions,
                    nutrition: recipe.nutrition,
                    author: authorViewData,
                    rating: recipe.rating,
                    time: recipe.time,
                    createdAt: recipe.createdAt,
                    image: recipeImage
                )
                recipeViewDataList.append(recipeViewData)
            }
        }

        return recipeViewDataList
    }

    func filterRecipesByCategory(by category: String?) {
        if let category = category, !category.isEmpty {
            let lowercasedCategory = category.lowercased()
            filteredRecipes = recipes.filter { recipe in
                recipe.category.contains { $0.lowercased() == lowercasedCategory }
            }
        } else {
            filteredRecipes = recipes
        }
    }

    func filterRecipesByAuthor(by author: String?) {
        if let author = author, !author.isEmpty {
            recipesByAuthor = recipes.filter { recipe in
                recipe.author.authorId == author
            }
        }
    }

    func filterMyFavRecipes(by myId: String?) {
        if let myId = myId, !myId.isEmpty {
            myFavRecipes = recipes.filter { recipe in
                recipe.author.authorId == myId
            }
        }
    }
}
