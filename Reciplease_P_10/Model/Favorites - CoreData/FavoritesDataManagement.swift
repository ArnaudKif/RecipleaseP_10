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
    public static let favoritesDataManagement = FavoritesDataManagement(context: AppDelegate.viewContext)

    // MARK: - Properties
    let favContext: NSManagedObjectContext

    public init(context:NSManagedObjectContext) {
        self.favContext = context
    }

    // MARK: - Methods
    // Save a recipe on CoreData
    func saveRecipe(recipeToSave: Recipe) {
        // Save the object in the context
        let recipe = FavoritesRecipesData(context: favContext)
        recipe.yield = recipeToSave.yield
        recipe.ingredientLines = recipeToSave.ingredientLines.joined(separator: ",")
        recipe.totalTime = Double(recipeToSave.totalTime)
        recipe.url = recipeToSave.url
        recipe.image = recipeToSave.image
        recipe.label = recipeToSave.label
        // Save the context
        try? favContext.save()
    }

    // Delete a recipe on CoreData
    func removeRecipe(recipeToRemove : Recipe) {
        // Remove the object in the context
        let request: NSFetchRequest<FavoritesRecipesData> = FavoritesRecipesData.fetchRequest()
        if let recipes = try? favContext.fetch(request) {
            for r in recipes {
                if r.url == recipeToRemove.url {
                    favContext.delete(r)
                }
            }
        }
        // Save the context
        try? AppDelegate.viewContext.save()
    }

    // Return all favorites recipes from CoreData in an array
    var all : [FavoritesRecipesData] {
        let request: NSFetchRequest<FavoritesRecipesData> = FavoritesRecipesData.fetchRequest()
        var recipes: [FavoritesRecipesData] = []
        if let r = try? favContext.fetch(request) {
            recipes = r
        }
        return recipes
    }

    // Check if the recipe is in favorites
    func isInFavorite(recipeUrl url : String) -> Bool {
        let request : NSFetchRequest<FavoritesRecipesData> = FavoritesRecipesData.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        var favoriteRecipe: [FavoritesRecipesData] = []
        if let recipes = try? favContext.fetch(request) {
            favoriteRecipe = recipes
        }
        if favoriteRecipe.isEmpty {
            return false
        } else {
        return true }
    }

}
