//
//  FavoritesManagement.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 29/11/2021.
//

import Foundation
import CoreData

class FavoritesDataManagement {
    // MARK: - pattern Singleton
    public static let favoritesDataManagement = FavoritesDataManagement()

    public init() {}

    // MARK: - Methods
    // Save a recipe on CoreData
    func saveRecipe(recipeToSave: Recipe) {
        // Save the object in the context
        let recipe = FavoritesRecipesData(context: AppDelegate.viewContext)
        recipe.yield = recipeToSave.yield
        recipe.ingredientLines = recipeToSave.ingredientLines.joined(separator: ",")
        recipe.totalTime = Double(recipeToSave.totalTime)
        recipe.url = recipeToSave.url
        recipe.image = recipeToSave.image
        recipe.label = recipeToSave.label
        // Save the context
        try? AppDelegate.viewContext.save()
    }

    // Delete a recipe on CoreData
    func removeRecipe(recipeToRemove : Recipe) {
        // Remove the object in the context
        let request: NSFetchRequest<FavoritesRecipesData> = FavoritesRecipesData.fetchRequest()
        if let recipes = try? AppDelegate.viewContext.fetch(request) {
            for r in recipes {
                if r.label == recipeToRemove.label {
                    AppDelegate.viewContext.delete(r)
                }
            }
        }
        // Save the context
        try? AppDelegate.viewContext.save()
    }

}
