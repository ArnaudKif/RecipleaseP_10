//
//  SearchService.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import Foundation

class SearchService {

    // MARK: - Pattern singleton
    static public let searchService = SearchService()

    public init() {}

    // MARK: - Properties
    // List of ingredient
    var ingredientList: [String] = []

    // List of ingredients for the request
    var ingredientListForResquest: String {
        ingredientList.joined(separator:",")
    }

    // MARK: - Methods
    // Method to add ingredient
    func addIngredient(ingredient: String){
        ingredientList.append(ingredient.capitalized)
    }

    // Method to clear ingredient
    func clearIngredients() {
        ingredientList.removeAll()
    }

}
