//
//  PreviewData.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation

var countryPreviewData = Country(id: 1, name: "Italy", isoAlpha2: "IT", flag: "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAUCAYAAACaq43EAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpBMzVCNDMyMDE3ODAxMUUyODY3Q0FBOTFCQzlGNjlDRiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpBMzVCNDMyMTE3ODAxMUUyODY3Q0FBOTFCQzlGNjlDRiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkEzNUI0MzFFMTc4MDExRTI4NjdDQUE5MUJDOUY2OUNGIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkEzNUI0MzFGMTc4MDExRTI4NjdDQUE5MUJDOUY2OUNGIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+oQE2+QAAAJNJREFUeNpiZJjk9pSBgUEKiD8zYAM/PjHy8Ir9fZK47D8/OzcLUOQ/A3bA+O/nz79Xnf0Yftx7wMwiJIhLHS8QP2OBMhiQaGzgH5RmYsAP/kMxIXW8hBSgG0oNNUT5gGZg1OJRi0ctHrV41OJRi4e2xYxUUgMGLNAmDy/Opg/EsL/QSh5v0weqDgSY8agD2wUQYAAUKyFbP8LJRAAAAABJRU5ErkJggg==")

var countriesPreviewData = [Country](repeating: countryPreviewData, count: 20)

var recipePreviewData = Recipe(id: "1", name: "Pasta al pomodoro", description: "A simple and tasty dish, perfect for a quick dinner."
                               , category: ["pranzo", "cena"], ingredients: [RecipeIngredient(name: "Pasta", imageUrl: "", quantity: "100g")], instructions: ["Cuocere la pasta"], nutrition: Nutrition(calories: 360, carbs: 60, proteins: 10, fats: 10), author: RecipeAuthor(authorId: "", name: "Raul Palade", description: "Dedicated chef committed to using fresh, seasonal ingredients to create culinary masterpieces", imageUrl: ""), rating: 4.8, time: "20 min", createdAt: "", imageUrl: "")

var recipesPreviewData = [Recipe](repeating: recipePreviewData, count: 5)
