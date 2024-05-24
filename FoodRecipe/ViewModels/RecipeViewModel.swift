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

class RecipeViewModel: ObservableObject {
    let db: Firestore
    let recipesRef: CollectionReference

    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var recipesByAuthor: [Recipe] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = true

    private var cancellables = Set<AnyCancellable>()

    init() {
        db = Firestore.firestore()
        recipesRef = db.collection("recipes")
        fetchRecipes()
    }

    func fetchRecipes() {
        let queryPublisher = Future<[Recipe], Error> { promise in
            Task {
                do {
                    let recipes = try await self.getRecipes()
                    promise(.success(recipes))
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
               let createdAt = data["createdAt"] as? String {
                let nutrition = Nutrition(
                    calories: nutritionData["calories"] ?? 0,
                    carbs: nutritionData["carbs"] ?? 0,
                    proteins: nutritionData["proteins"] ?? 0,
                    fats: nutritionData["fats"] ?? 0
                )

                let author = RecipeAuthor(
                    authorId: authorData["authorId"] ?? "",
                    name: authorData["name"] ?? "",
                    description: authorData["description"] ?? "",
                    imageUrl: authorData["imageUrl"] ?? ""
                )

                var recipe = Recipe(
                    id: documentID,
                    name: name,
                    description: description,
                    category: category,
                    ingredients: [],
                    instructions: instructions,
                    nutrition: nutrition,
                    author: author,
                    rating: rating,
                    time: time,
                    createdAt: createdAt,
                    imageUrl: imageUrl
                )

                let ingredients = try await fetchIngredients(for: documentID)
                recipe.ingredients = ingredients
                fetchedRecipes.append(recipe)
            } else {
                print("Error: Missing required fields in document data.")
            }
        }

        return fetchedRecipes
    }

    private func fetchIngredients(for recipeId: String) async throws -> [RecipeIngredient] {
        let ingredientsRef = recipesRef.document(recipeId).collection("ingredients")
        let querySnapshot = try await ingredientsRef.getDocuments()
        return querySnapshot.documents.compactMap { document in
            try? document.data(as: RecipeIngredient.self)
        }
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
        print(filterRecipesByAuthor)
        if let author = author, !author.isEmpty {
            recipesByAuthor = recipes.filter { recipe in
                recipe.author.authorId == author
            }
        }
    }
}
